import 'package:get/get.dart';
import 'package:todo_app_getx/presentation/controller/signup/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => SignUpController(
        signUpUseCase: Get.find(),
      ),
    );
  }
}
