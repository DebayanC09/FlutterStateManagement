import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/ui/cubit/signup/signup_cubit.dart';
import 'package:todo_app_cubit/ui/cubit/signup/signup_state.dart';
import 'package:todo_app_cubit/ui/views/todo/todo_list_screen.dart';
import 'package:todo_app_cubit/utils/asset_path.dart';
import 'package:todo_app_cubit/utils/functionality.dart';
import 'package:todo_app_cubit/widgets/custom_appbar.dart';
import 'package:todo_app_cubit/widgets/custom_button.dart';
import 'package:todo_app_cubit/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String name = "SignUpScreen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final SignUpCubit _cubitProvider = SignUpCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubitProvider,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            child: BlocConsumer<SignUpCubit, SignUpState>(
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
                      height: screenHeight(context) * 0.07,
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
                      controller: nameController,
                      labelText: "Name",
                      errorText: state.nameErrorText,
                      onChanged: (value) {
                        if (state.nameErrorText != null) {
                          _cubitProvider.setNameErrorText(nameErrorText: null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: "Email",
                      errorText: state.emailErrorText,
                      onChanged: (value) {
                        if (state.emailErrorText != null) {
                          _cubitProvider.setEmailErrorText(emailErrorText: null);
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
                          _cubitProvider.setPasswordErrorText(passwordErrorText: null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(state: state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _button({required SignUpState state}) {
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
          text: "SignUp",
          onPressed: () {
            _validate();
          });
    }
  }

  void _validate() async {
    hideKeyboard(context);
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    _cubitProvider.signUp(name: name, email: email, password: password);
  }
}
