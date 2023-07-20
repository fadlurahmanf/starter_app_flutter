import 'dart:io';
import 'package:dio/dio.dart';
import 'package:starter_app_flutter/core/external/constant/app_constant.dart';
import 'package:starter_app_flutter/core/feature/exception/base_exception.dart';
import 'package:starter_app_flutter/core/feature/exception/app_exception.dart';
import 'package:starter_app_flutter/core/feature/translation/translation_constant.dart';

class ResponseException extends BaseException {
  final int? httpStatusCode;
  final String? statusCode;

  ResponseException(
      {this.httpStatusCode,
      this.statusCode,
      super.rawTitleMessage,
      super.titleMessage,
      super.rawMessage,
      super.message,
      super.additionalData});

  factory ResponseException.fromException(DioException exception) {
    return ResponseException(
        httpStatusCode: exception.response?.statusCode,
        statusCode: getStatusCode(exception),
        rawTitleMessage: getCustomException(exception)?.rawTitleMessage,
        rawMessage: getCustomException(exception)?.rawMessage,
        additionalData: getAdditionalData(exception));
  }

  static String? getStatusCode(DioException exception) {
    final data = exception.response?.data;
    if (data is Map<String, dynamic> && data.containsKey('code')) {
      return '${data['code']}';
    } else {
      return null;
    }
  }

  static AppException? getCustomException(DioException exception) {
    if (exception.response?.statusCode == 500) {
      return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.INTERNAL_SERVER_ERROR);
    } else if (exception.type == DioExceptionType.connectionTimeout) {
      return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.CONNECT_TIMEOUT);
    } else if (exception.type == DioExceptionType.sendTimeout) {
      return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.SEND_TIMEOUT);
    } else if (exception.type == DioExceptionType.receiveTimeout) {
      return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.RECEIVE_TIMEOUT);
    } else if (exception.type == DioExceptionType.badResponse) {
      final data = exception.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: data['message']);
      } else if (exception.response?.statusCode == 404) {
        return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.ERR_NOT_FOUND);
      } else if (exception.response?.statusCode == 504) {
        return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.RECEIVE_TIMEOUT);
      } else if (exception.response?.statusCode == 500) {
        return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.INTERNAL_SERVER_ERROR);
      }
    } else if (exception.type == DioExceptionType.unknown) {
      if (exception.error is SocketException) {
        return AppException(rawTitleMessage: TranslationConstant.OOPS, rawMessage: AppConstant.OFFLINE);
      }
    }
    return null;
  }

  static Map<String, dynamic>? getAdditionalData(DioException exception) {
    final dataResp = exception.response?.data;
    if (dataResp is Map<String, dynamic>) {
      final data = dataResp['data'];
      if (data != null && data is Map<String, dynamic>) {
        return dataResp['data'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'httpStatusCode': httpStatusCode,
      'statusCode': statusCode,
      'rawTitleMessage': rawTitleMessage,
      'titleMessage': titleMessage,
      'rawMessage': rawMessage,
      'message': message,
      'additionalData': additionalData,
    };
  }

  AppException toAppException() {
    return AppException.fromResponseException(this);
  }
}
