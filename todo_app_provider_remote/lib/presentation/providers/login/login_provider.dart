import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/functionality.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/login/login_usecase.dart';

class LoginProvider with ChangeNotifier {
  late final LoginUseCase _loginUseCase;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String? _emailErrorText;

  String? get emailErrorText => _emailErrorText;

  String? _passwordErrorText;

  String? get passwordErrorText => _passwordErrorText;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  LoginProvider({required LoginUseCase loginUseCase}) {
    _loginUseCase = loginUseCase;
  }

  void setEmailErrorText(String? value) {
    _emailErrorText = value;
    notifyListeners();
  }

  void setPasswordErrorText(String? value) {
    _passwordErrorText = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<GeneralStatus<UserEntity>> validate() async {
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
      setIsLoading(false);
      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
        return GeneralStatus.success(
          message: response.message,
          data: response.data,
        );
      } else {
        return GeneralStatus.error(
          message: response.message,
        );
      }
    }
  }
}
