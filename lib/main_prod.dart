import 'package:starter_app_flutter/core/external/configuration/environment_model.dart';
import 'package:starter_app_flutter/main.dart';

const _env = ProdEnvironmentModel();

Future<void> main() async {
  startApp(model: _env);
}
