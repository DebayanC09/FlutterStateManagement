import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/asset_path.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/functionality.dart';
import '../../controller/login/login_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';
import '../signup/signup_screen.dart';
import '../todo/todo_list_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
          child: ListView(
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
                controller: _controller.emailController,
                labelText: "Email",
                errorText: _controller.emailErrorText,
                onChanged: (value) {
                  if (_controller.emailErrorText != null) {
                    _controller.setEmailErrorText(null);
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: _controller.passwordController,
                labelText: "Password",
                errorText: _controller.passwordErrorText,
                onChanged: (value) {
                  if (_controller.passwordErrorText != null) {
                    _controller.setPasswordErrorText(null);
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(() => _button(
                  isLoading: _controller.isLoading,
                ),
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
          _login();
        },
      );
    }
  }

  void _login() async {
    hideKeyboard(context);
    var response = await _controller.login();
    if (response.status == Status.success) {
      showToast(message: response.message);
      Get.offAllNamed(TodoListScreen.name);
    } else if (response.status == Status.error) {
      showToast(message: response.message);
    }
  }

  void _goToSignUp() {
    Get.toNamed(SignUpScreen.name);
  }
}
