import 'package:todo_app_bloc/data/models/general_status.dart';

class SignUpState {
  final String? nameErrorText;
  final String? emailErrorText;
  final String? passwordErrorText;
  final Status status;
  final String? message;

  const SignUpState({
    this.nameErrorText,
    this.emailErrorText,
    this.passwordErrorText,
    this.status = Status.idle,
    this.message,
  });

  SignUpState copyWith({
    String? nameErrorText,
    String? emailErrorText,
    String? passwordErrorText,
    Status status = Status.idle,
    String? message,
  }) {
    return SignUpState(
      nameErrorText: nameErrorText,
      emailErrorText: emailErrorText,
      passwordErrorText: passwordErrorText,
      status: status,
      message: message,
    );
  }
}
