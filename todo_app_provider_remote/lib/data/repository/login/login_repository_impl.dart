import '../../../core/state/general_status.dart';
import '../../../domain/repository/login/login_repository.dart';
import '../../datasource/remote/api_service.dart';
import '../../models/user_model.dart';
import '../../models/user_response.dart';

class LoginRepositoryImpl implements LoginRepository {
  late final ApiService _apiService;

  LoginRepositoryImpl({required ApiService apiService}) {
    _apiService = apiService;
  }

  @override
  Future<GeneralStatus<UserModel>> login({
    required String email,
    required String password,
  }) async {
    UserResponse response = await _apiService.login(
      email: email,
      password: password,
    );
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.user != null) {
      return GeneralStatus.success(
        message: response.message,
        data: response.user,
      );
    } else {
      return GeneralStatus.error(
        message: response.message,
      );
    }
  }
}
