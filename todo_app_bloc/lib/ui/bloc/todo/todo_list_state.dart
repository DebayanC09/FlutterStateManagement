import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/models/todo_model.dart';

class TodoListState {
  final Status status;
  final List<TodoModel> list;
  final String message;

  const TodoListState(
      {this.status = Status.idle,
      this.list = const <TodoModel>[],
      this.message = ""});

  TodoListState copyWith({
    final Status? status,
    final List<TodoModel>? list,
    final String? message,
  }) {
    return TodoListState(
      status: status ?? this.status,
      list: list ?? this.list,
      message: message ?? this.message,
    );
  }
}
