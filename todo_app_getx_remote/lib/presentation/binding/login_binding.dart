import 'package:get/get.dart';

import '../controller/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => LoginController(
        loginUseCase: Get.find(),
      ),
    );
  }
}
