import 'package:get/get.dart';
import 'package:starter_app_flutter/core/feature/exception/base_exception.dart';
import 'package:starter_app_flutter/core/feature/exception/response_exception.dart';
import 'package:starter_app_flutter/core/feature/translation/translation.dart';
import 'package:starter_app_flutter/core/feature/translation/translation_constant.dart';

class CustomException extends BaseException {
  CustomException({super.rawTitleMessage, super.titleMessage, super.rawMessage, super.message, super.additionalData});

  static fromResponseException(ResponseException e) {
    return CustomException(
        rawTitleMessage: e.rawTitleMessage,
        titleMessage: e.titleMessage,
        rawMessage: e.rawMessage,
        message: e.message,
        additionalData: e.additionalData);
  }

  CustomException getProperCustomException() {
    return CustomException(
        rawTitleMessage: rawTitleMessage,
        titleMessage: getTitleMessage(),
        rawMessage: rawMessage,
        message: getMessage(),
        additionalData: additionalData);
  }

  String getMessage() {
    if (message != null) {
      return message!;
    }

    if (rawMessage != null) {
      if (TranslationMessage().keys['en']?.containsKey(rawMessage!.toUpperCase()) == true ||
          TranslationMessage().keys['id']?.containsKey(rawMessage!.toUpperCase()) == true) {
        return rawMessage!.toUpperCase().tr;
      } else if (TranslationMessage().keys['en']?.containsKey(rawMessage!.toLowerCase()) == true ||
          TranslationMessage().keys['id']?.containsKey(rawMessage!.toLowerCase()) == true) {
        return rawMessage!.toLowerCase().tr;
      } else if (TranslationMessage().keys['en']?.containsKey(rawMessage) == true ||
          TranslationMessage().keys['id']?.containsKey(rawMessage) == true) {
        return rawMessage!.tr;
      }
    }

    return TranslationConstant.EXCEPTION_GENERAL.tr;
  }

  String getTitleMessage() {
    if (titleMessage != null) {
      return titleMessage!;
    }

    if (rawTitleMessage != null) {
      if (TranslationMessage().keys['en']?.containsKey(rawTitleMessage!.toUpperCase()) == true ||
          TranslationMessage().keys['id']?.containsKey(rawTitleMessage!.toUpperCase()) == true) {
        return rawTitleMessage!.toUpperCase().tr;
      } else if (TranslationMessage().keys['en']?.containsKey(rawTitleMessage!.toLowerCase()) == true ||
          TranslationMessage().keys['id']?.containsKey(rawTitleMessage!.toLowerCase()) == true) {
        return rawTitleMessage!.toLowerCase().tr;
      } else if (TranslationMessage().keys['en']?.containsKey(rawTitleMessage) == true ||
          TranslationMessage().keys['id']?.containsKey(rawTitleMessage) == true) {
        return rawTitleMessage!.tr;
      }
    }

    return TranslationConstant.OOPS.tr;
  }

  Map<String, dynamic> toJson() {
    return {
      'rawTitleMessage': rawTitleMessage,
      'titleMessage': titleMessage,
      'rawMessage': rawMessage,
      'message': message,
      'additionalData': additionalData
    };
  }
}
