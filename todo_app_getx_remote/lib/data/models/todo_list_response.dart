import 'todo_model.dart';

class TodoListResponse {
  String? statusCode;
  String? status;
  String? message;
  List<TodoModel>? todoList;

  TodoListResponse({
    this.statusCode,
    this.status,
    this.message,
    this.todoList,
  });

  TodoListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      todoList = <TodoModel>[];
      json['data'].forEach((v) {
        todoList?.add(TodoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (todoList != null) {
      data['data'] = todoList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
