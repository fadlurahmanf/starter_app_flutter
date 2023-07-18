import 'package:starter_app_flutter/core/external/configuration/base_environment.dart';

class DevEnvironmentSetting extends BaseEnvironmentSetting {
  const DevEnvironmentSetting()
      : super(
          env: 'DEV',
          baseUrl: 'http://api.bankmas.my.id/',
        );
}

class StagingEnvironmentSetting extends BaseEnvironmentSetting {
  const StagingEnvironmentSetting()
      : super(
          env: 'STAGING',
          baseUrl: 'http://api.bankmas.link/',
        );
}

class ProdEnvironmentSetting extends BaseEnvironmentSetting {
  const ProdEnvironmentSetting()
      : super(
          env: 'PROD',
          baseUrl: 'http://api.bankmas.net/',
        );
}
