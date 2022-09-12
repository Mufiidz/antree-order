import 'package:antree_order/models/api_response.dart';
import 'package:dio/dio.dart';

import '../config/dio_exception.dart';

extension AwaitResult<T> on Future<ApiResponse<T>> {
  Future<ApiResponse<T>> get awaitResult async {
    var apiResponse = ApiResponse<T>();
    await then((value) {
      apiResponse = value;
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError);
          apiResponse = onDioError(res, apiResponse);
          break;
        default:
          apiResponse.message = 'ERROR';
          break;
      }
    });
    return apiResponse;
  }

  ApiResponse<T> onDioError(DioError error, ApiResponse<T> apiResponse) {
    final res = error.response;
    var apires = apiResponse;
    if (res != null) {
      apires = ApiResponse.errorResponse('$res');
    } else {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      apires.code = res?.statusCode ?? 0;
      apires.message = errorMessage;
    }
    return apires;
  }
}
