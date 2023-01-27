import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:todo_app_cubit/data/network/auth_interceptor.dart';
import 'package:todo_app_cubit/data/network/pretty_dio_logger.dart';
import 'package:todo_app_cubit/utils/endpoints.dart';

class DioClient {
  final Dio _dio = Dio();
  static final DioClient _instance = DioClient._internal();

  DioClient._internal() {
    _dio.options = BaseOptions(
      baseUrl: Endpoints.baseURL(),
      connectTimeout: 50000,
      receiveTimeout: 50000,
      responseType: ResponseType.json,
    );
    _dio.interceptors.addAll([
      AuthInterceptor(),
      RetryInterceptor(
        dio: _dio,
        logPrint: print,
        retries: 1,
        retryableExtraStatuses: {401},
        retryDelays: const [
          Duration(seconds: 1),
        ],
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      )
    ]);
  }

  static DioClient getInstance() {
    return _instance;
  }

  Future<Response> getCall({required String endPoint}) async {
    return await _dio.get(endPoint);
  }

  Future<Response> postCall(
      {required String endPoint,
      Map<String, String>? data,
      FormData? formData}) async {
    if (formData != null) {
      return await _dio.post(endPoint, data: formData);
    } else {
      return await _dio.post(endPoint, data: data);
    }
  }
}
