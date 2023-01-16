import 'package:todo_app_provider/data/models/todo_list_response.dart';
import 'package:todo_app_provider/data/models/todo_model.dart';
import 'package:todo_app_provider/utils/constants.dart';

import '../../models/general_status.dart';
import '../../models/todo_response.dart';
import '../../network/api_service.dart';

class TodoRepository {
  TodoRepository._();

  static final List<TodoModel> _todoList = <TodoModel>[];

  static List<TodoModel> get todoList => List.unmodifiable(_todoList);

  static Future<GeneralStatus> totoList() async {
    TodoListResponse response = await ApiService.todoList();
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todoList != null) {
      _updateList(type: Constants.list, todoList: response.todoList);
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
      _updateList(type: Constants.add, todoData: response.todo as TodoModel);
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
      _updateList(type: Constants.update, todoData: response.todo as TodoModel);
      return GeneralStatus.success(
          message: response.message, data: response.todo);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }

  static Future<GeneralStatus> deleteTodo({required String id}) async {
    TodoResponse response = await ApiService.deleteTodo(id: id);
    if (response.statusCode == "200" &&
        response.status == "1") {
      _updateList(type: Constants.delete, id: id);
      return GeneralStatus.success(
          message: response.message, data: response.todo);
    } else {
      return GeneralStatus.error(message: response.message);
    }
  }


  static _updateList({required String type,List<TodoModel>? todoList, TodoModel? todoData, String? id}) {
    if (type == Constants.list) {
      if (todoList != null) {
        _todoList.clear();
        _todoList.addAll(todoList);
      }
    } else if (type == Constants.add) {
      if (todoData != null) {
        _todoList.add(todoData);
      }
    } else if (type == Constants.update) {
      if (todoData != null) {
        int index =
        _todoList.indexWhere((element) => element.id == todoData.id);
        _todoList[index] = todoData;
      }
    } else if (type == Constants.delete) {
      if (id != null) {
        _todoList.removeWhere((element) => element.id == id);
      }
    }
  }
}
