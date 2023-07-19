import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/domain/interactor/device_interactor.dart';
import 'package:starter_app_flutter/core/external/app_utility.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';
import 'package:starter_app_flutter/core/feature/di/core_module.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_config.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_constant.dart';
import 'package:starter_app_flutter/core/feature/translation/translation.dart';

Future<void> startApp({required EnvironmentSetting environment}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await CoreModule.init(environment: environment);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _locale = Locale('id', 'ID');

  @override
  void initState() {
    super.initState();
    _initLocale();
  }

  Future<void> _initLocale() async {
    await GetIt.I<DeviceInteractor>().insertOrUpdateDeviceIdIfExist();
    await Get.updateLocale(const Locale('id', 'ID')).then((value) {
      _locale = const Locale('id', 'ID');
    });
  }

  @override
  Widget build(BuildContext context) {
    return materialApp(context);
  }

  Widget materialApp(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: GetIt.I<EnvironmentSetting>().useAlice == true 
          ? AppGlobal.alice.getNavigatorKey() 
          : Get.key,
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
      locale: _locale,
      translationsKeys: TranslationMessage().keys,
      routes: NavigationConfig.getMapScreen(context),
      initialRoute: NavigationConstant.SPLASH,
      onUnknownRoute: NavigationConfig.getUnknownRoute(),
    );
  }
}
