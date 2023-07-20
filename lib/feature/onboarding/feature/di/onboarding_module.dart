// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/feature/di/external/constant.dart';
import 'package:starter_app_flutter/core/feature/network/dio_config.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/datasource/onboarding_datasource.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';

class OnBoardingModule {

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
    if (GetIt.I.isRegistered<Dio>(instanceName: DiConstant.onBoardingClient)) {
      GetIt.I.unregister<Dio>(instanceName: DiConstant.onBoardingClient);
    }
  }

  static Future<void> registerClient() async {
    GetIt.I.registerSingleton<Dio>(
      await DioConfig.getClient(interceptors: [], options: await DioConfig.getOOBOptions()),
      instanceName: DiConstant.onBoardingClient,
    );
  }

  static Future<void> loadDataSource() async {
    await unRegisterDatasource();
    await registerDatasource();
  }

  static Future<void> unRegisterDatasource() async {
    if (GetIt.I.isRegistered<OnBoardingDataSource>()) {
      GetIt.I.unregister<OnBoardingDataSource>();
    }
  }

  static Future<void> registerDatasource() async {
    GetIt.I.registerFactory<OnBoardingDataSource>(() => OnBoardingDataSource(
          client: GetIt.I<Dio>(instanceName: DiConstant.onBoardingClient),
        ));
  }

  static Future<void> loadInteractor() async {
    await unRegisterInteractor();
    await registerInteractor();
  }

  static Future<void> unRegisterInteractor() async {
    if (GetIt.I.isRegistered<VersionInteractor>()) {
      GetIt.I.unregister<VersionInteractor>();
    }
  }

  static Future<void> registerInteractor() async {
    GetIt.I.registerFactory(() => VersionInteractor(
          onBoardingDataSource: GetIt.I<OnBoardingDataSource>(),
        ));
  }
}
