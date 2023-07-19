import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';

class DevEnvironmentSetting extends EnvironmentSetting {
  const DevEnvironmentSetting()
      : super(
          env: 'DEV',
          baseUrl: 'http://api.bankmas.my.id/',
          useAlice: true,
        );
}

class StagingEnvironmentSetting extends EnvironmentSetting {
  const StagingEnvironmentSetting()
      : super(
          env: 'STAGING',
          baseUrl: 'http://api.bankmas.link/',
          useAlice: false,
        );
}

class ProdEnvironmentSetting extends EnvironmentSetting {
  const ProdEnvironmentSetting()
      : super(
          env: 'PROD',
          baseUrl: 'http://api.bankmas.net/',
          useAlice: false,
        );
}
