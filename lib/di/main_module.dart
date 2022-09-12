import 'package:antree_order/config/api_client.dart';
import 'package:antree_order/config/dio_client.dart';
import 'package:antree_order/data/auth_repository.dart';
import 'package:antree_order/route/guard/auth_content_guard.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route/guard/auth_guard.dart';
import '../export/export_package.dart';

final GetIt getIt = GetIt.I;

Future<void> setupDI() async {
  getIt.registerLazySingleton<AppRoute>(() =>
      AppRoute(authGuard: AuthGuard(), authContentGuard: AuthContentGuard()));
  getIt.registerSingleton<Dio>(DioClient.init);
  getIt.registerSingleton(ApiClient(getIt<Dio>()));
  getIt.registerSingleton(await SharedPreferences.getInstance());
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<ApiClient>(), getIt<SharedPreferences>()));
}
