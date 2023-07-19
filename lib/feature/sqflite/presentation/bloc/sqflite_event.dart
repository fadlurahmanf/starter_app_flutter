part of 'sqflite_bloc.dart';

@freezed
class SqfliteEvent with _$SqfliteEvent {
  const factory SqfliteEvent.insert({required String deviceId}) = _Insert;
  const factory SqfliteEvent.get() = _Get;
  const factory SqfliteEvent.delete() = _Delete;
}
