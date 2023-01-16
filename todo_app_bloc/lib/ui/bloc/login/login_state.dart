import 'package:todo_app_bloc/data/models/general_status.dart';

class LoginState {
  final String? emailErrorText;
  final String? passwordErrorText;
  final Status status;
  final String? message;

  const LoginState(
      {this.emailErrorText,
      this.passwordErrorText,
      this.status = Status.idle,
      this.message});

  LoginState copyWith({
    String? emailErrorText,
    String? passwordErrorText,
    Status status = Status.idle,
    String? message,
  }) {
    return LoginState(
      emailErrorText: emailErrorText,
      passwordErrorText: passwordErrorText,
      status: status,
      message: message,
    );
  }
}
