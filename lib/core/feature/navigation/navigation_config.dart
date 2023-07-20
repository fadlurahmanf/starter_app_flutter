import 'package:flutter/material.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_constant.dart';
import 'package:starter_app_flutter/feature/splash/presentation/splash_screen.dart';
import 'package:starter_app_flutter/feature/sqflite/presentation/example_sqflite_screen.dart';

class NavigationConfig {
  static Route Function(RouteSettings settings) getUnknownRoute() {
    return (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
              backgroundColor: Colors.blue,
            ));
  }

  static Map<String, Widget Function(BuildContext)> getMapScreen(
    BuildContext context,
  ) {
    return {
      // TODO(DEVELOPER): ADD SCREEN HERE
      NavigationConstant.SPLASH: (context) => const SplashScreen(),
      NavigationConstant.EXAMPLE_SQFLITE: (context) => const ExampleSqfliteScreen(),
    };
  }
}
