import 'package:antree_order/di/main_module.dart';
import 'package:antree_order/export/export_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp.router(
        title: 'Antree Order',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: getAppRoute().delegate(),
        routeInformationParser: getAppRoute().defaultRouteParser(),
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
        ],
      ),
    );
  }

  AppRoute getAppRoute() => getIt<AppRoute>();
}
