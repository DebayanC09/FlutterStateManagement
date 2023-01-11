import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_provider/data/models/general_status.dart';
import 'package:todo_app_provider/data/repository/login/login_repository.dart';
import 'package:todo_app_provider/utils/functionality.dart';

class LoginProvider with ChangeNotifier {
  String? _emailErrorText;

  String? get emailErrorText => _emailErrorText;

  String? _passwordErrorText;

  String? get passwordErrorText => _passwordErrorText;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

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

  Future<GeneralStatus> validate(
      {required String email, required String password}) async {
    bool isValidEmail = EmailValidator.validate(email);
    if (!isValidEmail) {
      setEmailErrorText("Please enter valid email address");
      return GeneralStatus.validationError();
    } else if (password.isEmpty) {
      setPasswordErrorText("Please enter password");
      return GeneralStatus.validationError();
    } else {
      setIsLoading(true);
      var response =
          await LoginRepository.login(email: email, password: password);
      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
      }
      setIsLoading(false);
      return response;
    }
  }
}
