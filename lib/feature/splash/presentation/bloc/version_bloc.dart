
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app_flutter/core/feature/exception/app_exception.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_app_flutter/core/external/extension/object.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/model/version_model.dart';

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
      emit(VersionState.success(versionModel: await versionInteractor.checkVersion()));
    } catch (e) {
      emit(VersionState.failed(exception: e.toAppException()));
    }
  }
}
