import 'package:dio/dio.dart';
import 'package:starter_app_flutter/core/data/dto/response/base_response.dart';
import 'package:starter_app_flutter/core/feature/network/external/app_option.dart';
import 'package:starter_app_flutter/core/feature/network/utility/handle_response.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/response/check_version_response.dart';

abstract class OnBoardingIRepository {
  Future<BaseResponse<CheckVersionResponse>> checkVersion();
}

class OnBoardingDataSource implements OnBoardingIRepository {
  final Dio client;

  OnBoardingDataSource({required this.client});

  @override
  Future<BaseResponse<CheckVersionResponse>> checkVersion() async {
    return handleResponse<BaseResponse<CheckVersionResponse>>(
        request: () async => client.get('apps/minimum-version',
            options: AppOption.getCustomOptions()),
        onSuccess: (resp) {
          return BaseResponse<CheckVersionResponse>.fromJson(
              resp.data, (json) =>
              CheckVersionResponse.fromJson(json as Map<String, dynamic>? ?? {}));
        }
    );
  }
}












