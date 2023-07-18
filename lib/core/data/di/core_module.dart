import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';
import 'package:starter_app_flutter/core/feature/sqflite/data/external/sqflite_config.dart';
import 'package:starter_app_flutter/core/feature/sqflite/domain/datasource/device_entity_datasource.dart';
import 'package:starter_app_flutter/feature/onboarding/data/di/onboarding_module.dart';

class CoreModule {
  static Future<void> init({required BaseEnvironmentSetting model}) async {
    GetIt.I.registerSingleton(model);
    // await loadDB();
    await loadModules();
  }

  static Future<void> loadDB() async {
    const model = DeviceDB();
    final deviceDBHelper = DeviceDBHelper(dbModel: model);
    await deviceDBHelper.init();
    GetIt.I.registerFactory(() async => DeviceEntityDatasource(db: await deviceDBHelper.getDB(), dbSetting: model));
  }

  static Future<void> loadModules() async {
    await OnBoardingModule.init();
  }
}
