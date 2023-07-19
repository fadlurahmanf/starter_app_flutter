import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/domain/common/base_layout.dart';
import 'package:starter_app_flutter/core/feature/navigation/external/navigation_constant.dart';
import 'package:starter_app_flutter/feature/onboarding/domain/interactor/version_interactor.dart';
import 'package:starter_app_flutter/feature/splash/presentation/bloc/version_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => VersionBloc(
                  versionInteractor: GetIt.I<VersionInteractor>()
              ))
        ],
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
  void initState() {
    super.initState();
    versionBloc = BlocProvider.of(context);
    versionBloc?.add(const VersionEvent.checkVersion());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<VersionBloc, VersionState>(listener: (_, state) {
            state.map(
                idle: (_) {},
                loading: (_) {},
                success: (res) {
                  Get.toNamed('page');
                },
                failed: (exc) {});
          })
        ],
        child: Scaffold(
          body: Center(
            child: BlocBuilder<VersionBloc, VersionState>(
              builder: (BuildContext context, state) {
                return state.map(idle: (_) {
                  return ElevatedButton(
                    onPressed: () async {},
                    child: const Text(
                      'IDLE',
                    ),
                  );
                }, loading: (_) {
                  return ElevatedButton(
                    onPressed: () async {},
                    child: const Text(
                      'LOADING',
                    ),
                  );
                }, success: (_) {
                  return ElevatedButton(
                    onPressed: () async {},
                    child: const Text(
                      'SUCCESS',
                    ),
                  );
                }, failed: (exc) {
                  return ElevatedButton(
                    onPressed: () async {
                      Get.toNamed(NavigationConstant.EXAMPLE_SQFLITE);
                    },
                    child: Text(
                      'FAILED ${exc.exception?.getProperCustomException().toJson()}',
                    ),
                  );
                });
              },
            ),
          ),
        ));
  }
}
