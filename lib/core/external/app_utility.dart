import 'package:alice/alice.dart';
import 'package:get/get.dart';

var _alice = Alice(
  showNotification: false,
  showInspectorOnShake: true,
  navigatorKey: Get.key,
);

class AppGlobal {
  AppGlobal._();

  static Alice get alice {
    return _alice;
  }
}

class AppUtility {}
