import 'package:alice/alice.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';

final _alice = Alice(
  showNotification: false,
  showInspectorOnShake: true,
  navigatorKey: Get.key,
);

final _logger = Logger();

void logd(String message, {bool logInAlice = false, StackTrace? trace}) {
  _logger.d(message, trace);
  if (logInAlice && GetIt.I<EnvironmentSetting>().useAlice == true) {
    _alice.addLog(AliceLog(message: message, stackTrace: trace));
  }
}

void loge(String message, {bool logInAlice = false, StackTrace? trace}) {
  _logger.e(message, trace);
  if (logInAlice && GetIt.I<EnvironmentSetting>().useAlice == true) {
    _alice.addLog(AliceLog(message: message, stackTrace: trace));
  }
}

class AppGlobal {
  AppGlobal._();

  static Alice get alice {
    return _alice;
  }
}

class AppUtility {}
