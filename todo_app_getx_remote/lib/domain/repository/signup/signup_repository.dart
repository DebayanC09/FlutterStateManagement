import '../../../core/state/general_status.dart';
import '../../entity/user_entity.dart';

abstract class SignUpRepository {
  Future<GeneralStatus<UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });
}
