import 'package:starter_app_flutter/core/external/extension/object.dart';
import 'package:starter_app_flutter/core/feature/exception/app_exception.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/datasource/onboarding_datasource.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/model/version_model.dart';

class VersionInteractor {
  final OnBoardingDataSource onBoardingDataSource;

  VersionInteractor({required this.onBoardingDataSource});

  Future<VersionModel> checkVersion() async {
    try {
      const appVersion = 1;
      final resp = await onBoardingDataSource.checkVersion();
      if (resp.data?.minimumVersion == null) {
        throw AppException(message: 'MINIMUM VERSION EMPTY');
      }
      final minimumVersion = resp.data!.minimumVersion!;
      if (resp.data?.latestVersion == null) {
        throw AppException(message: 'LATEST VERSION EMPTY');
      }
      final latestVersion = resp.data!.latestVersion!;
      if (appVersion < int.parse(minimumVersion)) {
        return const VersionModel(updateAvailable: true, forceUpdate: true);
      } else if (appVersion != latestVersion) {
        return const VersionModel(updateAvailable: true, forceUpdate: false);
      } else {
        return const VersionModel(updateAvailable: false, forceUpdate: false);
      }
    } catch (e) {
      throw e.toAppException();
    }
  }
}
