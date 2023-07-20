import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:starter_app_flutter/core/external/app_utility.dart';

class LoggerInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printCurl(options, logInAlice: true, origin: 'REQ-CURL');
    handler.next(options);
  }

  void _printCurl(RequestOptions options, {required bool logInAlice, required String origin}) {
    try {
      final components = <String>['curl --location'];
      components.add(" '${options.uri}'");
      components.add(r' \');
      for (var i = 0; i < options.headers.keys.length; i++) {
        final k = options.headers.keys.toList()[i];
        final v = options.headers[k];
        if (k != 'Cookie') {
          if (k.toUpperCase() == 'content-type'.toUpperCase() && '$v'.contains('application/json')) {
            components.add("\n--header 'Content-Type: application/json'");
          } else {
            components.add("\n--header '$k: $v'");
          }
        }
        if (i != options.headers.keys.length - 1) {
          components.add(r' \');
        }
      }

      if (options.data != null) {
        components.add(r' \');
        if (options.data is FormData) {
          // ignore: avoid_dynamic_calls
          options.data = Map.fromEntries(options.data.fields);
        }

        final data = json.encode(options.data);
        components.add("\n--data '$data'");
      }

      final res = '$origin: ${components.join()}';
    } catch (e) {
      loge(e.toString());
    }
  }
}
