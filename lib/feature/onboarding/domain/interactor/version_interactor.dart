import 'package:either_dart/either.dart';
import 'package:starter_app_flutter/core/data/dto/exception/custom_exception.dart';
import 'package:starter_app_flutter/core/data/dto/exception/response_exception.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/datasource/onboarding_datasource.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/request/check_version_request.dart';
import 'package:starter_app_flutter/feature/splash/presentation/bloc/version_bloc.dart';

class VersionInteractor {
  final OnBoardingDataSource onBoardingDataSource;

  VersionInteractor({required this.onBoardingDataSource});

  Future<Either<CustomException, VersionState>> checkVersion(CheckVersionRequest request) async {
    try {
      final resp = await onBoardingDataSource.checkVersion(request);
      if (resp.data?.minimumVersion == null) {
        throw CustomException(rawMessage: 'GAGAL');
      }
      final minimumVersion = resp.data!.minimumVersion!;
      if (resp.data?.latestVersion == null) {
        throw CustomException(rawMessage: 'GAGAL');
      }
      final latestVersion = resp.data!.latestVersion!;
      if (request.version < minimumVersion) {
        return const Right(VersionState.success(updateAvailable: true, forceUpdate: true));
      } else if (request.version != latestVersion) {
        return const Right(VersionState.success(updateAvailable: true, forceUpdate: false));
      } else {
        return const Right(VersionState.success(updateAvailable: false, forceUpdate: false));
      }
    } on ResponseException catch (e) {
      return Left(CustomException.fromResponseException(e));
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomException(rawMessage: e.toString()));
    }
  }
}
