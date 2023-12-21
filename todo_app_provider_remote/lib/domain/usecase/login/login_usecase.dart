import '../../../core/state/general_status.dart';
import '../../entity/user_entity.dart';
import '../../repository/login/login_repository.dart';

class LoginUseCase {
  late final LoginRepository _loginRepository;

  LoginUseCase({required LoginRepository loginRepository}) {
    _loginRepository = loginRepository;
  }

  Future<GeneralStatus<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return _loginRepository.login(
      email: email,
      password: password,
    );
  }
}
