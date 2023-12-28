import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/domain/usecase/login/login_usecase.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/functionality.dart';
import '../../../domain/entity/user_entity.dart';

class LoginController extends GetxController {
  late final LoginUseCase _loginUseCase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Rx<String?> _emailErrorText = null.obs;

  String? get emailErrorText => _emailErrorText.value;

  Rx<String?> _passwordErrorText = null.obs;

  String? get passwordErrorText => _passwordErrorText.value;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  LoginController({required LoginUseCase loginUseCase}) {
    _loginUseCase = loginUseCase;
  }

  void setEmailErrorText(String? value) {
    _emailErrorText = RxnString(value);
  }

  void setPasswordErrorText(String? value) {
    _passwordErrorText = RxnString(value);
  }

  void setIsLoading(bool value) {
    _isLoading.value = value;
  }

  Future<GeneralStatus<UserEntity>> login() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    bool isValidEmail = EmailValidator.validate(email);
    if (!isValidEmail) {
      setEmailErrorText("Please enter valid email address");
      return GeneralStatus.validationError();
    } else if (password.isEmpty) {
      setPasswordErrorText("Please enter password");
      return GeneralStatus.validationError();
    } else {
      setIsLoading(true);
      GeneralStatus<UserEntity> response = await _loginUseCase.login(
        email: email,
        password: password,
      );
      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
      }
      setIsLoading(false);
      return response;
    }
  }
}
