import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/ui/bloc/login/login_bloc.dart';
import 'package:todo_app_bloc/ui/bloc/login/login_event.dart';
import 'package:todo_app_bloc/ui/bloc/login/login_state.dart';
import 'package:todo_app_bloc/ui/views/signup/signup_screen.dart';
import 'package:todo_app_bloc/ui/views/todo/todo_list_screen.dart';
import 'package:todo_app_bloc/utils/asset_path.dart';
import 'package:todo_app_bloc/utils/colors.dart';
import 'package:todo_app_bloc/utils/functionality.dart';
import 'package:todo_app_bloc/widgets/custom_button.dart';
import 'package:todo_app_bloc/widgets/custom_text_button.dart';
import 'package:todo_app_bloc/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginBloc,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status == Status.success) {
                  showToast(message: state.message);
                  Navigator.pushNamedAndRemoveUntil(
                      context, TodoListScreen.name, (route) => false);
                }
                if (state.status == Status.error) {
                  showToast(message: state.message);
                }
              },
              builder: (context, state) {
                return ListView(
                  children: [
                    SizedBox(
                      height: screenHeight(context) * 0.15,
                    ),
                    Image.asset(
                      AssetPaths.logo,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: "Email",
                      errorText: state.emailErrorText,
                      onChanged: (value) {
                        if (state.emailErrorText != null) {
                          _loginBloc.add(EmailErrorText(emailErrorText: null));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      labelText: "Password",
                      errorText: state.passwordErrorText,
                      onChanged: (value) {
                        if (state.passwordErrorText != null) {
                          _loginBloc
                              .add(PasswordErrorText(passwordErrorText: null));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(
                      state: state,
                    ),
                    Center(
                      child: CustomTextButton(
                        text: "SignUp",
                        padding: const EdgeInsets.all(8.0),
                        color: AppColors.colorPrimary,
                        onPressed: () {
                          _goToSignUp();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _button({required LoginState state}) {
    if (state.status == Status.loading) {
      return const Center(
        child: SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return CustomButton(
          text: "Login",
          onPressed: () {
            _validate();
          });
    }
  }

  void _validate() async {
    hideKeyboard(context);
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    _loginBloc.add(Login(email: email, password: password));
  }

  void _goToSignUp() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }
}
