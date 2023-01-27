import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/data/repository/login/login_repository.dart';
import 'package:todo_app_cubit/ui/cubit/login/login_state.dart';
import 'package:todo_app_cubit/utils/functionality.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void login({required String email,required String password}) async {
    bool isValidEmail = EmailValidator.validate(email);
    if (!isValidEmail) {
      emit(const LoginState(emailErrorText: "Please enter valid email address"));
    } else if (password.isEmpty) {
      emit(const LoginState(passwordErrorText: "Please enter password"));
    } else {
      emit(const LoginState(status: Status.loading));

      var response = await LoginRepository.login(email: email, password: password);

      if (response.status == Status.success && response.data != null) {
        setUserData(user: response.data);
        emit(LoginState(status: Status.success, message: response.message));
      } else {
        emit(LoginState(status: Status.error, message: response.message));
      }
    }
  }

  void setEmailErrorText({required String? emailErrorText}) {
    emit(state.copyWith(emailErrorText: emailErrorText));
  }

  void setPasswordErrorText({required String? passwordErrorText}) {
    emit(state.copyWith(emailErrorText: passwordErrorText));
  }
}
