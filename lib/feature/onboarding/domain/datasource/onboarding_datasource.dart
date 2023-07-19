import 'package:dio/dio.dart';
import 'package:starter_app_flutter/core/data/dto/response/base_response.dart';
import 'package:starter_app_flutter/core/feature/network/external/app_option.dart';
import 'package:starter_app_flutter/core/feature/network/external/handle_response.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/request/check_version_request.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/response/check_version_response.dart';

abstract class OnBoardingIRepository {
  Future<BaseResponse<CheckVersionResponse>> checkVersion(CheckVersionRequest request);
}

class OnBoardingDataSource implements OnBoardingIRepository {
  final Dio client;

  OnBoardingDataSource({required this.client});

  @override
  Future<BaseResponse<CheckVersionResponse>> checkVersion(CheckVersionRequest request) async {
    return handleResponse<BaseResponse<CheckVersionResponse>>(
        request: () async => client.get('apps/minimum-version', data: request.toJson(),
            options: AppOption.getCustomOptions()),
        onSuccess: (resp) {
          return BaseResponse<CheckVersionResponse>.fromJson(
              resp.data, (json) =>
              CheckVersionResponse.fromJson(json as Map<String, dynamic>? ?? {}));
        }
    );
  }
}












