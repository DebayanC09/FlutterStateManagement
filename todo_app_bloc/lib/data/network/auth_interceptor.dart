import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_bloc/data/models/user_model.dart';
import 'package:todo_app_bloc/data/network/api_service.dart';
import 'package:todo_app_bloc/main.dart';
import 'package:todo_app_bloc/ui/views/login/login_screen.dart';
import 'package:todo_app_bloc/utils/functionality.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    UserModel? user = await getUserData();
    options.headers['Authorization'] = user?.token;

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String token = await ApiService.refreshToken();
      err.requestOptions.headers['Authorization'] = token;
      await updateToken(token: token);
    } else if (err.response?.statusCode == 403) {
      try {
        setUserData(user: null);
        showToast(message: err.response?.data['message']);
        BuildContext? context = MyApp.navigatorKey.currentContext;
        Navigator.pushNamedAndRemoveUntil(
            context!, LoginScreen.name, (route) => false);
      } catch (e) {
        super.onError(err, handler);
      }
    }
    super.onError(err, handler);
  }
}
