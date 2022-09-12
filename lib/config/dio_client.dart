import 'package:dio/dio.dart';

import '../export/export.dart';

class DioClient {
  DioClient._();

  static Dio get init => Dio(BaseOptions(
        baseUrl: Const.baseUrl,
        connectTimeout: Const.connectionTimeout,
        receiveTimeout: Const.receiveTimeout,
        responseType: ResponseType.json,
        headers: {
          "Access-Control-Allow-Credentials": true,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, DELETE, POST, PATCH, OPTIONS",
          "Access-Control-Allow-Headers": "Content-Type, Authorization"
        },
      ))
        ..interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ));
}
