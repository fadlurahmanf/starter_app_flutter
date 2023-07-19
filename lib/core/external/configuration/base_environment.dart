import 'package:starter_app_flutter/core/domain/common/base_description.dart';

abstract class EnvironmentSetting extends Description {
  final String env;
  final String baseUrl;
  final bool useAlice;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;

  const EnvironmentSetting(
      {required this.env,
      required this.baseUrl,
      required this.useAlice,
      this.connectTimeout = 60 * 1000,
      this.sendTimeout = 60 * 1000,
      this.receiveTimeout = 60 * 1000,
      String? linkFigma,
      String? description})
      : super(
            linkFigma: null, description: 'Konfigurasi untuk enviroment/flavor, development, staging, pre-prod, prod');
}
