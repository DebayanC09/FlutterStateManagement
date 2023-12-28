import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/asset_path.dart';
import '../../../core/utils/functionality.dart';
import '../../controller/signup/signup_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../todo/todo_list_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = "/SignUpScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
          child: ListView(
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
                controller: _controller.nameController,
                labelText: "Name",
                errorText: _controller.nameErrorText,
                onChanged: (value) {
                  if (_controller.nameErrorText != null) {
                    _controller.setNameErrorText(null);
                  }
                },
              ),
              const SizedBox(
                height: 16,
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
              _button(
                isLoading: _controller.isLoading,
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
        text: "SignUp",
        onPressed: () {
          _register();
        },
      );
    }
  }

  void _register() async {
    hideKeyboard(context);
    var response = await _controller.register();
    if (response.status == Status.success) {
      showToast(message: response.message);
      Get.offAllNamed(TodoListScreen.name);
    } else if (response.status == Status.error) {
      showToast(message: response.message);
    }
  }
}
