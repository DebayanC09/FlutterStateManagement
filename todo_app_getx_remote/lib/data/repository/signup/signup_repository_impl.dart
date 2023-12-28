import '../../../core/state/general_status.dart';
import '../../../domain/repository/signup/signup_repository.dart';
import '../../datasource/remote/api_service.dart';
import '../../models/user_model.dart';
import '../../models/user_response.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  late final ApiService _apiService;

  SignUpRepositoryImpl({required ApiService apiService}) {
    _apiService = apiService;
  }

  @override
  Future<GeneralStatus<UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserResponse response = await _apiService.register(
      name: name,
      email: email,
      password: password,
    );
    if (response.statusCode == "201" &&
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
