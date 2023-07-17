class EnvironmentConfigModel {
  static const String _description = 'Konfigurasi untuk enviroment/flavor, development, staging, pre-prod, prod';
  final String env;
  final String baseUrl;

  EnvironmentConfigModel({required this.env, required this.baseUrl});
}
