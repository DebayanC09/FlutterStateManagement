import 'package:get/get.dart';
import 'package:todo_app_getx/presentation/controller/todo/todo_list_controller.dart';

class TodoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TodoListController(
        todoUseCase: Get.find(),
      ),
    );
  }
}
