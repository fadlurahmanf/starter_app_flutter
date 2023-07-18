import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_app_flutter/core/data/di/core_module.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_config.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_constant.dart';

Future<void> startApp({required BaseEnvironmentSetting model}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await CoreModule.init(model: model);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: 'Starter App Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      routes: NavigationConfig.getMapScreen(context),
      initialRoute: NavigationConstant.SPLASH,
      onUnknownRoute: NavigationConfig.getUnknownRoute(),
    );
  }
}
