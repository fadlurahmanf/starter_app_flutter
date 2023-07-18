import 'package:starter_app_flutter/core/external/configuration/base_environment_model.dart';

class DevEnvironmentModel extends BaseEnvironmentModel {
  const DevEnvironmentModel()
      : super(
          env: 'DEV',
          baseUrl: 'http://api.bankmas.my.id/',
        );
}

class StagingEnvironmentModel extends BaseEnvironmentModel {
  const StagingEnvironmentModel()
      : super(
          env: 'STAGING',
          baseUrl: 'http://api.bankmas.link/',
        );
}

class ProdEnvironmentModel extends BaseEnvironmentModel {
  const ProdEnvironmentModel()
      : super(
          env: 'PROD',
          baseUrl: 'http://api.bankmas.net/',
        );
}
