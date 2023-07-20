part of 'sqflite_bloc.dart';

@freezed
class SqfliteState with _$SqfliteState {
  const factory SqfliteState.idle() = _Idle;

  /// insert
  const factory SqfliteState.iLoading() = _ILoading;

  const factory SqfliteState.iSuccess() = _ISuccess;

  const factory SqfliteState.iFailed({required AppException exception}) = _IFailed;

  /// get
  const factory SqfliteState.gLoading() = _GLoading;

  const factory SqfliteState.gSuccess({required List<DeviceEntity> devices}) = _GSuccess;

  const factory SqfliteState.gFailed({required AppException exception}) = _GFailed;

  /// delete
  const factory SqfliteState.dLoading() = _DLoading;

  const factory SqfliteState.dSuccess() = _DSuccess;

  const factory SqfliteState.dFailed({required AppException exception}) = _DFailed;
}
