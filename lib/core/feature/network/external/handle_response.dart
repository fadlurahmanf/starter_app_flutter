import 'package:dio/dio.dart';
import 'package:starter_app_flutter/core/feature/exception/response_exception.dart';

Future<T> handleResponse<T>({
  required Future<Response<dynamic>> Function() request,
  required T Function(Response<dynamic>) onSuccess,
}) async {
  try {
    final result = await request();
    return onSuccess(result);
  } on DioException catch (e) {
    throw ResponseException.fromException(e);
  } catch (e) {
    throw ResponseException(rawMessage: e.toString());
  }
}
