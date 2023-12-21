import '../../../core/state/general_status.dart';
import '../../entity/todo_entity.dart';
import '../../repository/todo/todo_repository.dart';

class TodoUseCase {
  late final TodoRepository _todoRepository;

  TodoUseCase({required TodoRepository todoRepository}) {
    _todoRepository = todoRepository;
  }

  Future<GeneralStatus<List<TodoEntity>>> getTodoList() async {
    return _todoRepository.totoList();
  }

  Future<GeneralStatus<TodoEntity>> deleteTodo({required String id}) async {
    return _todoRepository.deleteTodo(id: id);
  }

  List<TodoEntity> get todoList => _todoRepository.todoList;

  Future<GeneralStatus<TodoEntity>> addTodo({
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    return _todoRepository.addTodo(
      title: title,
      description: description,
      dateTime: dateTime,
      priority: priority,
    );
  }

  Future<GeneralStatus<TodoEntity>> updateTodo({
    required String id,
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    return _todoRepository.updateTodo(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      priority: priority,
    );
  }
}
