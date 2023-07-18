import 'package:dio/dio.dart';

class CustomOptions {
  static Options getCustomOptions(){
    return Options(
      headers: {
        'TYPE_REQUEST': 'CUSTOM'
      }
    );
  }
}