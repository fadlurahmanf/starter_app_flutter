import 'package:either_dart/either.dart';
import 'package:starter_app_flutter/core/external/extension/object.dart';
import 'package:starter_app_flutter/core/feature/exception/custom_exception.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/datasource/onboarding_datasource.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/request/check_version_request.dart';
import 'package:starter_app_flutter/feature/splash/presentation/bloc/version_bloc.dart';

class VersionInteractor {
  final OnBoardingDataSource onBoardingDataSource;

  VersionInteractor({required this.onBoardingDataSource});

  Future<Either<CustomException, VersionState>> checkVersion(CheckVersionRequest request) async {
    try {
      const appVersion = 1;
      final resp = await onBoardingDataSource.checkVersion(request);
      if (resp.data?.minimumVersion == null) {
        throw CustomException(message: 'MINIMUM VERSION EMPTY');
      }
      final minimumVersion = resp.data!.minimumVersion!;
      if (resp.data?.latestVersion == null) {
        throw CustomException(message: 'LATEST VERSION EMPTY');
      }
      final latestVersion = resp.data!.latestVersion!;
      if (appVersion < int.parse(minimumVersion)) {
        return const Right(VersionState.success(updateAvailable: true, forceUpdate: true));
      } else if (appVersion != latestVersion) {
        return const Right(VersionState.success(updateAvailable: true, forceUpdate: false));
      } else {
        return const Right(VersionState.success(updateAvailable: false, forceUpdate: false));
      }
    } catch (e) {
      return Left(e.toCustomException());
    }
  }
}
