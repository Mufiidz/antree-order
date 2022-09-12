import 'package:antree_order/di/main_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../export/export.dart';

class AuthGuard extends AutoRouteGuard {
  static final AuthGuard _instance = AuthGuard._internal();

  factory AuthGuard() {
    return _instance;
  }

  AuthGuard._internal();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final sharedPreferences = getIt<SharedPreferences>();
    final token = sharedPreferences.getString(Const.token) ?? '';
    var isLoggedIn = token.isNotEmpty;
    if (isLoggedIn == true) {
      resolver.next();
    } else {
      router.replaceAll([LoginRoute(resolver: resolver)]);
    }
  }
}
