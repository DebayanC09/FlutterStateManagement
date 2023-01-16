import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/models/user_response.dart';
import 'package:todo_app_bloc/data/network/api_service.dart';

class LoginRepository {
  LoginRepository._();

  static Future<GeneralStatus> login(
      {required String email, required String password}) async {
    UserResponse response =
        await ApiService.login(email: email, password: password);
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.user != null) {
      return GeneralStatus.success(
          message: response.message, data: response.user);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }
}
