import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/data/repository/signup/signup_repository.dart';
import 'package:todo_app_cubit/ui/cubit/signup/signup_state.dart';
import 'package:todo_app_cubit/utils/functionality.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void signUp(
      {required String name,
      required String email,
      required String password}) async {
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

  void setNameErrorText({required String? nameErrorText}) {
    emit(state.copyWith(nameErrorText: nameErrorText));
  }

  void setEmailErrorText({required String? emailErrorText}) {
    emit(state.copyWith(emailErrorText: emailErrorText));
  }

  void setPasswordErrorText({required String? passwordErrorText}) {
    emit(state.copyWith(passwordErrorText: passwordErrorText));
  }
}
