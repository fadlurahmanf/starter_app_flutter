import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_version_response.g.dart';
part 'check_version_response.freezed.dart';

@freezed
class CheckVersionResponse with _$CheckVersionResponse {
  const factory CheckVersionResponse({
    @JsonKey(name: 'minVersion')
    String? minimumVersion,
    int? latestVersion,
  }) = _CheckVersionReponse;

  factory CheckVersionResponse.fromJson(Map<String, dynamic> json) => _$CheckVersionResponseFromJson(json);
}
