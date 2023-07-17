import 'package:starter_app_flutter/core/data/dto/model/environment_config_model.dart';
import 'package:starter_app_flutter/main.dart';

Future<void> main() async {
  startApp(
      model: EnvironmentConfigModel(
    env: 'dev',
    baseUrl: 'http://api.bankmas.my.id/',
  ));
}
