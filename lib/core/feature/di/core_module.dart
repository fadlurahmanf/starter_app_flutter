import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/domain/interactor/device_interactor.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';
import 'package:starter_app_flutter/core/feature/di/external/constant.dart';
import 'package:starter_app_flutter/core/feature/sqflite/device/data/external/sqflite_config.dart';
import 'package:starter_app_flutter/core/feature/sqflite/device/domain/datasource/device_entity_datasource.dart';
import 'package:starter_app_flutter/feature/onboarding/feature/di/onboarding_module.dart';

class CoreModule {
  static Future<void> init({required EnvironmentSetting environment}) async {
    GetIt.I.registerSingleton(environment);
    await loadDataSource();
    await loadInteractor();
    await loadModules();
  }

  static Future<void> loadDataSource() async {
    await unregisterDataSource();
    await registerDataSource();
  }

  static Future<void> unregisterDataSource() async {
    if (GetIt.I.isRegistered<DeviceEntityDatasource>()) {
      GetIt.I.unregister<DeviceEntityDatasource>();
    }
  }

  static Future<void> registerDataSource() async {
    const model = DeviceDB();
    final deviceDBHelper = DeviceDBHelper(dbModel: model);
    await deviceDBHelper.init();
    final db = await deviceDBHelper.getDB();
    GetIt.I.registerFactory<DeviceEntityDatasource>(() => DeviceEntityDatasource(db: db),
        instanceName: DiConstant.deviceEntityDatasource);
  }

  static Future<void> loadInteractor() async {
    await unregisterDataSource();
    await registerInteractor();
  }

  static Future<void> unregisterInteractor() async {
    if (GetIt.I.isRegistered<DeviceEntityDatasource>()) {
      GetIt.I.unregister<DeviceEntityDatasource>();
    }
  }

  static Future<void> registerInteractor() async {
    GetIt.I.registerFactory<DeviceInteractor>(() => DeviceInteractor(
          deviceEntityDatasource: GetIt.I<DeviceEntityDatasource>(instanceName: DiConstant.deviceEntityDatasource),
          deviceInfo: DeviceInfoPlugin(),
        ));
  }

  static Future<void> loadModules() async {
    await OnBoardingModule.init();
  }
}
