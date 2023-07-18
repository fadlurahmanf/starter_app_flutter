import 'package:starter_app_flutter/core/data/dto/exception/base_exception.dart';
import 'package:starter_app_flutter/core/data/dto/exception/response_exception.dart';

class CustomException extends BaseException {
  CustomException(
      {super.rawTitleMessage, super.titleMessage, super.rawMessage, super.properMessage, super.additionalData});

  static fromResponseException(ResponseException e) {
    return CustomException(
        rawTitleMessage: e.rawTitleMessage,
        titleMessage: e.titleMessage,
        rawMessage: e.rawMessage,
        properMessage: e.properMessage,
        additionalData: e.additionalData);
  }
}
