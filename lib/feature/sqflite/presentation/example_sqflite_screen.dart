import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_app_flutter/core/domain/interactor/device_interactor.dart';
import 'package:starter_app_flutter/feature/sqflite/presentation/bloc/sqflite_bloc.dart';

class ExampleSqfliteScreen extends StatelessWidget {
  const ExampleSqfliteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SqfliteBloc(deviceInteractor: GetIt.I<DeviceInteractor>()),
          )
        ],
        child: _ExampleSqfliteLayout(
          key: key,
        ));
  }
}

class _ExampleSqfliteLayout extends StatefulWidget {
  const _ExampleSqfliteLayout({Key? key}) : super(key: key);

  @override
  State<_ExampleSqfliteLayout> createState() => _ExampleSqfliteLayoutState();
}

class _ExampleSqfliteLayoutState extends State<_ExampleSqfliteLayout> {
  SqfliteBloc? sqfliteBloc;

  @override
  void initState() {
    super.initState();
    sqfliteBloc = BlocProvider.of<SqfliteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<SqfliteBloc, SqfliteState>(listener: (context, state) {
            state.mapOrNull(
                idle: (state) {},
                iLoading: (state) {
                  print('mask state loading');
                },
                iSuccess: (state) {
                  print('masuk state success');
                },
                gSuccess: (state) {
                  state.devices.forEach((element) {
                    print('masuk ${element.toJson()}');
                  });
                });
          })
        ],
        child: Scaffold(
          body: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    sqfliteBloc?.add(const SqfliteEvent.get());
                  },
                  child: const Text('GET'),
                )
              ],
            ),
          ),
        ));
  }
}
