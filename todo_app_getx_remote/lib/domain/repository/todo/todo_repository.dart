import '../../../core/state/general_status.dart';
import '../../entity/todo_entity.dart';

abstract class TodoRepository {
  List<TodoEntity> get todoList;

  Future<GeneralStatus<List<TodoEntity>>> totoList();

  Future<GeneralStatus<TodoEntity>> addTodo({
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  });

  Future<GeneralStatus<TodoEntity>> updateTodo({
    required String id,
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  });

  Future<GeneralStatus<TodoEntity>> deleteTodo({required String id});
}
