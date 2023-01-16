import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/repository/login/login_repository.dart';
import 'package:todo_app_bloc/ui/bloc/login/login_event.dart';
import 'package:todo_app_bloc/ui/bloc/login/login_state.dart';
import 'package:todo_app_bloc/utils/functionality.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<Login>(_login);
    on<EmailErrorText>(_setEmailErrorText);
    on<PasswordErrorText>(_setPasswordErrorText);
  }

  FutureOr<void> _login(Login event, Emitter<LoginState> emit) async {
    String email = event.email;
    String password = event.password;

    bool isValidEmail = EmailValidator.validate(email);
    if (!isValidEmail) {
      emit(
          const LoginState(emailErrorText: "Please enter valid email address"));
    } else if (password.isEmpty) {
      emit(const LoginState(passwordErrorText: "Please enter password"));
    } else {
      emit(const LoginState(status: Status.loading));

      var response =
          await LoginRepository.login(email: email, password: password);

      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
        emit(LoginState(status: Status.success, message: response.message));
      } else {
        emit(LoginState(status: Status.error, message: response.message));
      }
    }
  }

  FutureOr<void> _setEmailErrorText(
      EmailErrorText event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailErrorText: event.emailErrorText));
  }

  FutureOr<void> _setPasswordErrorText(
      PasswordErrorText event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailErrorText: event.passwordErrorText));
  }
}
