import '../../../core/state/general_status.dart';
import '../../entity/user_entity.dart';
import '../../repository/signup/signup_repository.dart';

class SignUpUseCase {
  late final SignUpRepository _signUpRepository;

  SignUpUseCase({required SignUpRepository signUpRepository}) {
    _signUpRepository = signUpRepository;
  }

  Future<GeneralStatus<UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _signUpRepository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}
