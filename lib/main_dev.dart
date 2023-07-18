import 'package:starter_app_flutter/core/external/configuration/environment_setting.dart';
import 'package:starter_app_flutter/main.dart';

const _env = DevEnvironmentSetting();

Future<void> main() async {
  startApp(model: _env);
}
