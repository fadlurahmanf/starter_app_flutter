import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/domain/common/base_layout.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';
import 'package:starter_app_flutter/feature/splash/data/dto/request/check_version_request.dart';
import 'package:starter_app_flutter/feature/splash/presentation/bloc/version_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MASUK SPLASH");
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => VersionBloc(versionInteractor: GetIt.I<VersionInteractor>()))],
        child: _SplashLayout(
          key: key,
        ));
  }
}

class _SplashLayout extends StatefulWidget {
  const _SplashLayout({Key? key}) : super(key: key);

  @override
  State<_SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<_SplashLayout> with BaseLayout {
  VersionBloc? versionBloc;

  @override
  Widget build(BuildContext context) {
    versionBloc = BlocProvider.of(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<VersionBloc, VersionState>(listener: (_, state) {
            print("MASUK STATE ${state.runtimeType}");
            state.map(idle: (_) {
              print("IDLE");
            }, loading: (_) {
              print("LOADING");
            }, success: (tes) {
              print("SUKSES");
            }, failed: (exc) {
              print("FAILED");
            });
          })
        ],
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                versionBloc?.add(VersionEvent.checkVersion(request: CheckVersionRequest(version: 101)));
              },
              child: Text(
                'SPLASH',
              ),
            ),
          ),
        ));
  }
}
