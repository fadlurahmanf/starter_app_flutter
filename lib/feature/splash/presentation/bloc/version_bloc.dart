import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app_flutter/core/data/dto/exception/custom_exception.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/request/check_version_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_bloc.freezed.dart';

part 'version_event.dart';

part 'version_state.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  final VersionInteractor versionInteractor;

  VersionBloc({required this.versionInteractor}) : super(const VersionState.idle()) {
    on<VersionEvent>((event, emit) async {
      await event.map(checkVersion: (event) async => await _checkVersion(event, emit));
    });
  }

  Future<void> _checkVersion(_CheckVersion event, Emitter<VersionState> emit) async {
    try {
      emit(const VersionState.idle());
      emit(const VersionState.loading());
      final res = await versionInteractor.checkVersion(event.request);
      if (res.isRight) {
        emit(res.right);
      } else {
        emit(VersionState.failed(exception: res.left));
      }
    } catch (e) {
      emit(VersionState.failed(exception: CustomException(rawMessage: e.toString())));
    }
  }
}
