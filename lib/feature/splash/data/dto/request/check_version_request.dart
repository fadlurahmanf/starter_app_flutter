import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_version_request.g.dart';

part 'check_version_request.freezed.dart';

@freezed
class CheckVersionRequest with _$CheckVersionRequest {
  const factory CheckVersionRequest({
    required String os,
  }) = _CheckVersionRequest;

  factory CheckVersionRequest.fromJson(Map<String, dynamic> json) => _$CheckVersionRequestFromJson(json);
}
