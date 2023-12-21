import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/functionality.dart';
import '../../../domain/usecase/signup/signup_usecase.dart';

class SignUpProvider with ChangeNotifier {
  late final SignUpUseCase _signUpUseCase;

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  SignUpProvider({required SignUpUseCase signUpUseCase}) {
    _signUpUseCase = signUpUseCase;
  }

  String? _nameErrorText;

  String? get nameErrorText => _nameErrorText;

  String? _emailErrorText;

  String? get emailErrorText => _emailErrorText;

  String? _passwordErrorText;

  String? get passwordErrorText => _passwordErrorText;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setNameErrorText(String? value) {
    _nameErrorText = value;
    notifyListeners();
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

  Future<GeneralStatus> validate() async {
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
      var response = await _signUpUseCase.register(
          name: name, email: email, password: password);
      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
      }
      setIsLoading(false);
      return response;
    }
  }
}
