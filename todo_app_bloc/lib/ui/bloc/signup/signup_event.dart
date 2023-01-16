abstract class SignUpEvent {}

class SignUp extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  SignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

class NameErrorText extends SignUpEvent {
  final String? nameErrorText;

  NameErrorText({required this.nameErrorText});
}

class EmailErrorText extends SignUpEvent {
  final String? emailErrorText;

  EmailErrorText({required this.emailErrorText});
}

class PasswordErrorText extends SignUpEvent {
  final String? passwordErrorText;

  PasswordErrorText({required this.passwordErrorText});
}
