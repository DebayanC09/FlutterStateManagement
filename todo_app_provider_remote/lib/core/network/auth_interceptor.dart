import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import '../../domain/entity/user_entity.dart';
import '../../presentation/views/login/login_screen.dart';
import '../utils/endpoints.dart';
import '../utils/functionality.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    UserEntity? user = await getUserData();
    options.headers['Authorization'] = user?.token;

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        String token = (await _dio.get(Endpoints.refreshToken)).data["token"];
        err.requestOptions.headers['Authorization'] = token;
        await updateToken(token: token);
      } catch (e) {
        super.onError(err, handler);
      }
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
