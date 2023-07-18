import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

part 'base_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    final bool? status,
    final String? code,
    final String? message,
    final T? data,
  }) = _BaseResponse;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson<T>(json, fromJsonT);
}
