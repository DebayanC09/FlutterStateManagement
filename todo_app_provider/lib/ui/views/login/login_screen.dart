import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/data/models/general_status.dart';
import 'package:todo_app_provider/ui/providers/login/login_provider.dart';
import 'package:todo_app_provider/ui/views/signup/signup_screen.dart';
import 'package:todo_app_provider/ui/views/todo/todo_list_screen.dart';
import 'package:todo_app_provider/utils/asset_path.dart';
import 'package:todo_app_provider/utils/colors.dart';
import 'package:todo_app_provider/utils/functionality.dart';
import 'package:todo_app_provider/widgets/custom_button.dart';
import 'package:todo_app_provider/widgets/custom_text_button.dart';
import 'package:todo_app_provider/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final LoginProvider _provider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            child: Consumer<LoginProvider>(
              builder: (context, consumerData, child) {
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
                      errorText: consumerData.emailErrorText,
                      onChanged: (value) {
                        if (_provider.emailErrorText != null) {
                          _provider.setEmailErrorText(null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      labelText: "Password",
                      errorText: consumerData.passwordErrorText,
                      onChanged: (value) {
                        if (_provider.passwordErrorText != null) {
                          _provider.setPasswordErrorText(null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(
                      isLoading: consumerData.isLoading,
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

  Widget _button({required bool isLoading}) {
    if (isLoading) {
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
    _provider.validate(email: email, password: password).then(
          (response) => {
            if (response.status == Status.success)
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, TodoListScreen.name, (route) => false),
                showToast(message: response.message)
              }
            else if (response.status == Status.error)
              {showToast(message: response.message)}
          },
        );
  }

  void _goToSignUp() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }
}
