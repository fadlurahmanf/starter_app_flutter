import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_entity.freezed.dart';
part 'device_entity.g.dart';

@freezed
class DeviceEntity with _$DeviceEntity {
  const factory DeviceEntity({
    required String deviceId,
    String? languageCode,
    String? createdAt,
  }) = _DeviceEntity;

  factory DeviceEntity.fromJson(Map<String, dynamic> json) => _$DeviceEntityFromJson(json);

  static const String table = 'device';
  static const String cDeviceId = 'deviceId';
  static const String cLanguageCode = 'languageCode';
  static const String cCreatedAt = 'createdAt';
}