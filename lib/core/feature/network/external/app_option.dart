import 'package:dio/dio.dart';

class AppOption {
  static Options getCustomOptions(){
    return Options(
      headers: {
        'TYPE_REQUEST': 'CUSTOM',
      }
    );
  }
}