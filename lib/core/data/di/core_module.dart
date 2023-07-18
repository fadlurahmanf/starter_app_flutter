import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment_model.dart';
import 'package:starter_app_flutter/core/external/configuration/environment_model.dart';
import 'package:starter_app_flutter/feature/onboarding/data/di/onboarding_module.dart';

class CoreModule {
  static Future<void> init({required BaseEnvironmentModel model}) async {
    GetIt.I.registerSingleton(model);
    await loadModules();
  }

  static Future<void> loadModules() async {
    await OnBoardingModule.init();
  }
}
