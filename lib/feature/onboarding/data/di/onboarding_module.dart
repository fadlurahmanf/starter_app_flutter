// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/feature/network/external/dio_config.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/datasource/onboarding_datasource.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';

class OnBoardingModule {
  static const onBoardingClient = 'onBoardingClient';

  static const onBoardingDataSource = 'onBoardingDataSource';

  static const onBoardingModuleVersionInteractor = 'onBoardingModule.VersionInteractor';

  static Future<void> init() async {
    await loadClient();
    await loadDataSource();
    await loadInteractor();
  }

  static Future<void> loadClient() async {
    await unRegisterClient();
    await registerClient();
  }

  static Future<void> unRegisterClient() async {
    if (GetIt.I.isRegistered<Dio>(instanceName: onBoardingClient)) {
      GetIt.I.unregister<Dio>(instanceName: onBoardingClient);
    }
  }

  static Future<void> registerClient() async {
    GetIt.I.registerSingleton(() => DioConfig.getClient(interceptors: []), instanceName: onBoardingClient);
  }

  static Future<void> loadDataSource() async {
    await unRegisterDatasource();
    await registerDatasource();
  }

  static Future<void> unRegisterDatasource() async {
    if (GetIt.I.isRegistered<OnBoardingDataSource>(instanceName: onBoardingDataSource)) {
      GetIt.I.unregister<OnBoardingDataSource>(instanceName: onBoardingDataSource);
    }
  }

  static Future<void> registerDatasource() async {
    GetIt.I.registerSingleton(() => OnBoardingDataSource(client: GetIt.I<Dio>(instanceName: onBoardingClient)),
        instanceName: onBoardingDataSource);
  }

  static Future<void> loadInteractor() async {
    await unRegisterInteractor();
    await registerInteractor();
  }

  static Future<void> unRegisterInteractor() async {
    if (GetIt.I.isRegistered<VersionInteractor>(instanceName: onBoardingModuleVersionInteractor)) {
      GetIt.I.unregister<VersionInteractor>(instanceName: onBoardingModuleVersionInteractor);
    }
  }

  static Future<void> registerInteractor() async {
    GetIt.I.registerSingleton(() =>
        VersionInteractor(onBoardingDataSource: GetIt.I<OnBoardingDataSource>(instanceName: onBoardingDataSource)),
        instanceName: onBoardingModuleVersionInteractor);
  }
}
