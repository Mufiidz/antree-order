import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/main_module.dart';
import '../../export/export.dart';

class AuthContentGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final sharedPreferences = getIt<SharedPreferences>();
    final token = sharedPreferences.getString(Const.token) ?? '';
    var isLoggedIn = token.isNotEmpty;
    if (isLoggedIn == true) {
      router.replaceAll([const HomeRoute()]);
    } else {
      resolver.next();
    }
  }
}
