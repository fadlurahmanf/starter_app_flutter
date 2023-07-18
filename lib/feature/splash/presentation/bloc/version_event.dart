part of 'version_bloc.dart';

@freezed
class VersionEvent with _$VersionEvent {
  const factory VersionEvent.checkVersion({required CheckVersionRequest request}) = _CheckVersion;
}
