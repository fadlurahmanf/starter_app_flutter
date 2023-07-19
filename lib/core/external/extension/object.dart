import 'package:starter_app_flutter/core/feature/exception/custom_exception.dart';
import 'package:starter_app_flutter/core/feature/exception/response_exception.dart';

extension ObjectX on Object {
  CustomException toCustomException() {
    if (this is CustomException) {
      return this as CustomException;
    } else if (this is ResponseException) {
      return CustomException.fromResponseException((this as ResponseException));
    } else {
      return CustomException(rawMessage: toString());
    }
  }
}
