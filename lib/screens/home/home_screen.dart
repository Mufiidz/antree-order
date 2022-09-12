import 'package:antree_order/di/main_module.dart';
import 'package:antree_order/export/export.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SelectableText(getToken())],
      ),
    );
  }

  String getToken() {
    final sharedPref = getIt<SharedPreferences>();
    return sharedPref.getString(Const.token) ?? 'HOME';
  }
}
