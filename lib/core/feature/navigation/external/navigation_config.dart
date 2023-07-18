import 'package:flutter/material.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_constant.dart';
import 'package:starter_app_flutter/feature/splash/presentation/splash_screen.dart';

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
    return {NavigationConstant.SPLASH: (context) => const SplashScreen()};
  }
}
