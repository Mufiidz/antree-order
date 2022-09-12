import 'package:antree_order/config/api_client.dart';
import 'package:antree_order/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../export/export.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<ApiResponse<String>> register(User user);
  Future<ApiResponse<User>> login(User user);
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final SharedPreferences _sharedPreferences;

  AuthRepositoryImpl(this._apiClient, this._sharedPreferences);

  @override
  Future<ApiResponse<User>> login(User user) async {
    final response = await _apiClient.login(user.toLogin()).awaitResult;
    if (response.data != null && (response.data?.token != null)) {
      final user = response.data ?? User();
      _sharedPreferences.setString(Const.token, user.token);
    }
    return response;
  }

  @override
  Future<ApiResponse<String>> register(User user) async =>
      await _apiClient.register(user.toRegister()).awaitResult;
}
