part of 'version_bloc.dart';

@freezed
class VersionState with _$VersionState {
  const factory VersionState.idle() = _Idle;
  const factory VersionState.loading() = _Loading;
  const factory VersionState.success({
    required VersionModel versionModel,
  }) = _Success;
  const factory VersionState.failed({
    AppException? exception,
  }) = _Failed;
}
