import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/data/models/user_response.dart';
import 'package:todo_app_cubit/data/network/api_service.dart';

class SignUpRepository {
  SignUpRepository._();

  static Future<GeneralStatus> register(
      {required String name,
      required String email,
      required String password}) async {
    UserResponse response =
        await ApiService.register(name: name, email: email, password: password);
    if (response.statusCode == "201" &&
        response.status == "1" &&
        response.user != null) {
      return GeneralStatus.success(
          message: response.message, data: response.user);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }
}
