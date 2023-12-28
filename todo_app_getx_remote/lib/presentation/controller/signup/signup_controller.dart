import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/domain/usecase/signup/signup_usecase.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/functionality.dart';
import '../../../domain/entity/user_entity.dart';

class SignUpController extends GetxController {
  late final SignUpUseCase _signUpUseCase;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Rx<String?> _nameErrorText = null.obs;

  String? get nameErrorText => _nameErrorText.value;

  Rx<String?> _emailErrorText = null.obs;

  String? get emailErrorText => _emailErrorText.value;

  Rx<String?> _passwordErrorText = null.obs;

  String? get passwordErrorText => _passwordErrorText.value;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  SignUpController({required SignUpUseCase signUpUseCase}) {
    _signUpUseCase = signUpUseCase;
  }

  void setNameErrorText(String? value) {
    _nameErrorText = RxnString(value);
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

  Future<GeneralStatus<UserEntity>> register() async {
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    bool isValidEmail = EmailValidator.validate(email);
    if (name.isEmpty) {
      setNameErrorText("Please enter name");
      return GeneralStatus.validationError();
    } else if (!isValidEmail) {
      setEmailErrorText("Please enter valid email address");
      return GeneralStatus.validationError();
    } else if (password.isEmpty) {
      setPasswordErrorText("Please enter password");
      return GeneralStatus.validationError();
    } else {
      setIsLoading(true);
      GeneralStatus<UserEntity> response = await _signUpUseCase.register(
        name: name,
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
