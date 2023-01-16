import 'package:todo_app_bloc/data/models/todo_model.dart';

abstract class TodoListEvent {}

class GetTodoList extends TodoListEvent {}

class TodoListResponse extends TodoListEvent {
  final List<TodoModel> list;

  TodoListResponse({required this.list});
}

class DeleteTodo extends TodoListEvent {
  final TodoModel item;

  DeleteTodo({required this.item});
}
