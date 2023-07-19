import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_app_flutter/core/domain/interactor/device_interactor.dart';
import 'package:starter_app_flutter/core/external/extension/object.dart';
import 'package:starter_app_flutter/core/feature/exception/custom_exception.dart';
import 'package:starter_app_flutter/core/feature/sqflite/data/dto/entity/device_entity.dart';

part 'sqflite_bloc.freezed.dart';

part 'sqflite_event.dart';

part 'sqflite_state.dart';

class SqfliteBloc extends Bloc<SqfliteEvent, SqfliteState> {
  final DeviceInteractor deviceInteractor;

  SqfliteBloc({required this.deviceInteractor}) : super(const SqfliteState.idle()) {
    on<SqfliteEvent>((event, emit) async {
      await event.map(
        insert: (event) async => _insert(event, emit),
        get: (event) async => _get(event, emit),
        delete: (event) async => null,
      );
    });
  }

  Future<void> _insert(_Insert event, Emitter<SqfliteState> emit) async {
    try {
      emit(const SqfliteState.idle());
      emit(const SqfliteState.iLoading());
      await deviceInteractor.insertOrUpdateDeviceIdIfExist();
      emit(const SqfliteState.iLoading());
    } catch (e) {
      emit(SqfliteState.iFailed(exception: e.toCustomException()));
    }
  }

  Future<void> _get(_Get event, Emitter<SqfliteState> emit) async {
    try {
      emit(const SqfliteState.idle());
      emit(const SqfliteState.iLoading());
      final res = await deviceInteractor.getAll();
      if (res.isRight) {
        emit(res.right);
      } else {
        emit(SqfliteState.gFailed(exception: res.left));
      }
    } catch (e) {
      emit(SqfliteState.gFailed(exception: e.toCustomException()));
    }
  }
}
