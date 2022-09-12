import 'package:antree_order/route/guard/auth_content_guard.dart';
import 'package:antree_order/screens/home/home_screen.dart';
import 'package:antree_order/screens/login/login_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'guard/auth_guard.dart';
import '../screens/register/regsiter_screen.dart';

part 'app_route.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: [
  AutoRoute(path: "/", page: HomeScreen, guards: [AuthGuard]),
  AutoRoute(path: "/login", page: LoginScreen, guards: [AuthContentGuard]),
  AutoRoute(path: "/register", page: RegisterScreen, guards: [AuthContentGuard])
])
class AppRoute extends _$AppRoute {
  AppRoute({required super.authGuard, required super.authContentGuard});
}
