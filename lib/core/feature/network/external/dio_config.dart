import 'package:dio/dio.dart';

class DioConfig {
  static Future<Dio> getClient({required List<Interceptors> interceptors}) async {
    final dio = Dio();
    return dio;
  }
}