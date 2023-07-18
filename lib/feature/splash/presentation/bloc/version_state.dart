part of 'version_bloc.dart';

@freezed
class VersionState with _$VersionState {
  const factory VersionState.idle() = _Idle;
  const factory VersionState.loading() = _Loading;
  const factory VersionState.success({
    bool? updateAvailable,
    bool? forceUpdate,
  }) = _Success;
  const factory VersionState.failed({
    CustomException? exception,
  }) = _Failed;
}
