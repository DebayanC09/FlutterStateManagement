abstract class LoginEvent {}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class EmailErrorText extends LoginEvent {
  final String? emailErrorText;

  EmailErrorText({required this.emailErrorText});
}

class PasswordErrorText extends LoginEvent {
  final String? passwordErrorText;

  PasswordErrorText({required this.passwordErrorText});
}
