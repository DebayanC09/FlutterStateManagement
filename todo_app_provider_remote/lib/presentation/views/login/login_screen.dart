import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/asset_path.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/functionality.dart';
import '../../../di/injector.dart';
import '../../providers/login/login_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';
import '../signup/signup_screen.dart';
import '../todo/todo_list_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final AppInjector _injector = AppInjector();
  late LoginProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AppInjector.getIt<LoginProvider>();
  }

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
                      controller: _provider.emailController,
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
                      controller: _provider.passwordController,
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
    _provider.validate().then(
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
