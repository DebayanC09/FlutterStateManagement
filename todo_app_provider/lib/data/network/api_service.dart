import 'package:dio/dio.dart';
import 'package:todo_app_provider/data/models/todo_list_response.dart';
import 'package:todo_app_provider/data/models/user_response.dart';
import 'package:todo_app_provider/data/network/dio_client.dart';
import 'package:todo_app_provider/utils/endpoints.dart';

import '../models/todo_response.dart';

class ApiService {
  ApiService._();

  static Future<UserResponse> login(
      {required String email, required String password}) async {
    try {
      Map<String, String> data = {"email": email, "password": password};
      var response = await DioClient.getInstance()
          .postCall(endPoint: Endpoints.userLogin, data: data);
      return UserResponse.fromJson(response.data);
    } catch (e) {
      return UserResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  static Future<UserResponse> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      Map<String, String> data = {
        "name": name,
        "email": email,
        "password": password
      };
      var response = await DioClient.getInstance()
          .postCall(endPoint: Endpoints.userRegister, data: data);
      return UserResponse.fromJson(response.data);
    } catch (e) {
      return UserResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  static Future<String> refreshToken() async {
    try {
      var response = await DioClient.getInstance()
          .getCall(endPoint: Endpoints.refreshToken);
      return response.data["token"];
    } catch (e) {
      return "";
    }
  }

  static Future<TodoResponse> addTodo(
      {required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    try {
      var formData = FormData.fromMap({
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "priority": priority,
      });

      var response = await DioClient.getInstance()
          .postCall(endPoint: Endpoints.addTodo, formData: formData);
      return TodoResponse.fromJson(response.data);
    } catch (e) {
      return TodoResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  static Future<TodoListResponse> todoList() async {
    try {
      var response =
          await DioClient.getInstance().getCall(endPoint: Endpoints.todoList);
      return TodoListResponse.fromJson(response.data);
    } catch (e) {
      return TodoListResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  static Future<TodoResponse> updateTodo(
      {required String id,
      required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    try {
      var formData = FormData.fromMap({
        "todoId": id,
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "priority": priority,
      });

      var response = await DioClient.getInstance()
          .postCall(endPoint: Endpoints.updateTodo, formData: formData);
      return TodoResponse.fromJson(response.data);
    } catch (e) {
      return TodoResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  static Future<TodoResponse> deleteTodo({required String id}) async {
    try {
      var formData = FormData.fromMap({"todoId": id});

      var response = await DioClient.getInstance()
          .postCall(endPoint: Endpoints.deleteTodo, formData: formData);
      return TodoResponse.fromJson(response.data);
    } catch (e) {
      return TodoResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }
}
