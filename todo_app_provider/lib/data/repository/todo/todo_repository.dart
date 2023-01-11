import 'package:todo_app_provider/data/models/todo_list_response.dart';

import '../../models/general_status.dart';
import '../../models/todo_response.dart';
import '../../network/api_service.dart';

class TodoRepository {
  TodoRepository._();

  static Future<GeneralStatus> totoList() async {
    TodoListResponse response = await ApiService.todoList();
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todoList != null) {
      return GeneralStatus.success(
          message: response.message, data: response.todoList);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }

  static Future<GeneralStatus> addTodo(
      {required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    TodoResponse response = await ApiService.addTodo(
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority);
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todo != null) {
      return GeneralStatus.success(
          message: response.message, data: response.todo);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }

  static Future<GeneralStatus> updateTodo(
      {required String id,
      required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    TodoResponse response = await ApiService.updateTodo(
        id: id,
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority);
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todo != null) {
      return GeneralStatus.success(
          message: response.message, data: response.todo);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }

  static Future<GeneralStatus> deleteTodo({required String id}) async {
    TodoResponse response = await ApiService.deleteTodo(id: id);
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todo != null) {
      return GeneralStatus.success(
          message: response.message, data: response.todo);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }
}
