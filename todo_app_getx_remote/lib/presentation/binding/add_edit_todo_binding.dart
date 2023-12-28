import 'package:get/get.dart';
import 'package:todo_app_getx/presentation/controller/todo/add_edit_todo_controller.dart';

class AddEditTodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => AddEditTodoController(
        todoUseCase: Get.find(),
      ),
    );
  }
}
