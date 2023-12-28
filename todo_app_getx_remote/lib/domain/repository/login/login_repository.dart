import '../../../core/state/general_status.dart';
import '../../entity/user_entity.dart';

abstract class LoginRepository {
  Future<GeneralStatus<UserEntity>> login({
    required String email,
    required String password,
  });
}
