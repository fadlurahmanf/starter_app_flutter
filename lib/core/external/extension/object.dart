import 'package:starter_app_flutter/core/feature/exception/app_exception.dart';
import 'package:starter_app_flutter/core/feature/exception/response_exception.dart';

extension ObjectX on Object {
  AppException toAppException() {
    if (this is AppException) {
      return this as AppException;
    } else if (this is ResponseException) {
      return AppException.fromResponseException((this as ResponseException));
    } else {
      return AppException(rawMessage: toString());
    }
  }
}
