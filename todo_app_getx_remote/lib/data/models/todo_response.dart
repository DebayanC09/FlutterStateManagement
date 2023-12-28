import 'todo_model.dart';

class TodoResponse {
  String? statusCode;
  String? status;
  String? message;
  TodoModel? todo;

  TodoResponse({
    this.statusCode,
    this.status,
    this.message,
    this.todo,
  });

  TodoResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    todo = json['data'] != null ? TodoModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (todo != null) {
      data['data'] = todo?.toJson();
    }
    return data;
  }
}
