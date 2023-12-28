import 'package:dio/dio.dart';

import '../../models/todo_list_response.dart';
import '../../models/todo_response.dart';
import '../../../core/utils/endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../models/user_response.dart';

class ApiService {
  late final DioClient _dioClient;

  ApiService({
    required DioClient dioClient,
  }) {
    _dioClient = dioClient;
  }

  Future<UserResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, String> data = {
        "email": email,
        "password": password,
      };
      var response = await _dioClient.postCall(
        endPoint: Endpoints.userLogin,
        data: data,
      );
      return UserResponse.fromJson(response.data);
    } catch (e) {
      return UserResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  Future<UserResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, String> data = {
        "name": name,
        "email": email,
        "password": password
      };
      var response = await _dioClient.postCall(
        endPoint: Endpoints.userRegister,
        data: data,
      );
      return UserResponse.fromJson(response.data);
    } catch (e) {
      return UserResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  Future<TodoResponse> addTodo({
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    try {
      var formData = FormData.fromMap({
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "priority": priority,
      });

      var response = await _dioClient.postCall(
        endPoint: Endpoints.addTodo,
        formData: formData,
      );
      return TodoResponse.fromJson(response.data);
    } catch (e) {
      return TodoResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  Future<TodoListResponse> todoList() async {
    try {
      var response = await _dioClient.getCall(endPoint: Endpoints.todoList);
      return TodoListResponse.fromJson(response.data);
    } catch (e) {
      return TodoListResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  Future<TodoResponse> updateTodo({
    required String id,
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    try {
      var formData = FormData.fromMap({
        "todoId": id,
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "priority": priority,
      });

      var response = await _dioClient.postCall(
        endPoint: Endpoints.updateTodo,
        formData: formData,
      );
      return TodoResponse.fromJson(response.data);
    } catch (e) {
      return TodoResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

  Future<TodoResponse> deleteTodo({required String id}) async {
    try {
      var formData = FormData.fromMap({"todoId": id});

      var response = await _dioClient.postCall(
        endPoint: Endpoints.deleteTodo,
        formData: formData,
      );
      return TodoResponse.fromJson(response.data);
    } catch (e) {
      return TodoResponse(
        statusCode: "",
        status: "-1",
        message: "Something went wrong",
      );
    }
  }

// Future<String> refreshToken() async {
//   try {
//     var response = await _dioClient.getCall(endPoint: Endpoints.refreshToken);
//     return response.data["token"];
//   } catch (e) {
//     return "";
//   }
// }
}
