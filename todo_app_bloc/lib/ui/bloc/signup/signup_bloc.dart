import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/repository/signup/signup_repository.dart';
import 'package:todo_app_bloc/ui/bloc/signup/signup_event.dart';
import 'package:todo_app_bloc/ui/bloc/signup/signup_state.dart';
import 'package:todo_app_bloc/utils/functionality.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUp>(_signUp);
    on<NameErrorText>(_setNameErrorText);
    on<EmailErrorText>(_setEmailErrorText);
    on<PasswordErrorText>(_setPasswordErrorText);
  }

  FutureOr<void> _signUp(SignUp event, Emitter<SignUpState> emit) async {
    String name = event.name;
    String email = event.email;
    String password = event.password;

    bool isValidEmail = EmailValidator.validate(email);
    if (name.isEmpty) {
      emit(const SignUpState(nameErrorText: "Please enter name"));
    } else if (!isValidEmail) {
      emit(const SignUpState(
          emailErrorText: "Please enter valid email address"));
    } else if (password.isEmpty) {
      emit(const SignUpState(passwordErrorText: "Please enter password"));
    } else {
      emit(const SignUpState(status: Status.loading));

      var response = await SignUpRepository.register(
          name: name, email: email, password: password);

      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
        emit(SignUpState(status: Status.success, message: response.message));
      } else {
        emit(SignUpState(status: Status.error, message: response.message));
      }
    }
  }

  FutureOr<void> _setNameErrorText(
      NameErrorText event, Emitter<SignUpState> emit) {
    emit(state.copyWith(nameErrorText: event.nameErrorText));
  }

  FutureOr<void> _setEmailErrorText(
      EmailErrorText event, Emitter<SignUpState> emit) {
    emit(state.copyWith(emailErrorText: event.emailErrorText));
  }

  FutureOr<void> _setPasswordErrorText(
      PasswordErrorText event, Emitter<SignUpState> emit) {
    emit(state.copyWith(emailErrorText: event.passwordErrorText));
  }
}
