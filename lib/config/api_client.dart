import 'package:antree_order/export/export.dart';
import 'package:antree_order/models/api_response.dart';
import 'package:antree_order/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(Endpoints.login)
  Future<ApiResponse<User>> login(@Body() Map<String, dynamic> json);

  @POST(Endpoints.register)
  Future<ApiResponse<String>> register(@Body() Map<String, dynamic> json);
}
