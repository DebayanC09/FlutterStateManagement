import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../utils/endpoints.dart';
import 'auth_interceptor.dart';
import 'pretty_dio_logger.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: Endpoints.baseURL(),
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      responseType: ResponseType.json,
    );
    _dio.interceptors.addAll([
      AuthInterceptor(_dio),
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
