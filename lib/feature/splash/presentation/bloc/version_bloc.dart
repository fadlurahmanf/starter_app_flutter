import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app_flutter/core/feature/exception/custom_exception.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/request/check_version_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_app_flutter/core/external/extension/object.dart';

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
      final request = CheckVersionRequest(os: Platform.operatingSystem);
      emit(const VersionState.idle());
      emit(const VersionState.loading());
      final res = await versionInteractor.checkVersion(request);
      if (res.isRight) {
        emit(res.right);
      } else {
        emit(VersionState.failed(exception: res.left));
      }
    } catch (e) {
      emit(VersionState.failed(exception: e.toCustomException()));
    }
  }
}
