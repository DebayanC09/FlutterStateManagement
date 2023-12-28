import 'package:get/get.dart';
import 'package:todo_app_getx/domain/entity/todo_entity.dart';

import '../../../core/state/general_status.dart';
import '../../../domain/usecase/todo/todo_usecase.dart';

class TodoListController extends GetxController {
  late final TodoUseCase _todoUseCase;

  final RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  static final RxList<TodoEntity> _todoList = <TodoEntity>[].obs;

  List<TodoEntity> get todoList => List.unmodifiable(_todoList);

  TodoListController({required TodoUseCase todoUseCase}) {
    _todoUseCase = todoUseCase;
  }

  void setIsLoading(bool value) {
    _isLoading.value = value;
  }

  void getTodoList() async {
    await _todoUseCase.getTodoList();
    updateList();
    setIsLoading(false);
  }

  void updateList() {
    _todoList.clear();
    _todoList.addAll(_todoUseCase.todoList);
  }

  Future<GeneralStatus<TodoEntity>> deleteTodo(
      {required TodoEntity todoData}) async {
    setIsLoading(true);
    GeneralStatus<TodoEntity> response =
        await _todoUseCase.deleteTodo(id: todoData.id ?? "");
    updateList();
    setIsLoading(false);
    return response;
  }
}
