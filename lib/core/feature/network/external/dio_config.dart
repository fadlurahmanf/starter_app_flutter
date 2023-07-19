import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:starter_app_flutter/core/external/app_utility.dart';
import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';

class DioConfig {
  static Future<Dio> getClient({required List<Interceptor> interceptors, required BaseOptions options}) async {
    final dio = Dio();
    dio.options = options;
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    if (GetIt.I<EnvironmentSetting>().useAlice == true) {
      dio.interceptors.add(AppGlobal.alice.getDioInterceptor());
    }
    for (var element in interceptors) {
      dio.interceptors.add(element);
    }
    return dio;
  }

  static Future<BaseOptions> getBaseOptions() async {
    return BaseOptions(
        connectTimeout: Duration(seconds: GetIt.I<EnvironmentSetting>().connectTimeout),
        sendTimeout: Duration(seconds: GetIt.I<EnvironmentSetting>().sendTimeout),
        receiveTimeout: Duration(seconds: GetIt.I<EnvironmentSetting>().receiveTimeout),
        headers: {'OS': Platform.operatingSystem, HttpHeaders.authorizationHeader: 'Basic YXBwLWNvbnN1bWVyOmZvbw=='});
  }

  static Future<BaseOptions> getOOBOptions() async {
    return await getBaseOptions()
      ..baseUrl = '${GetIt.I<EnvironmentSetting>().baseUrl}content-management-service/';
  }
}
