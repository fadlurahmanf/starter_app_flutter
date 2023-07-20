import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ExampleLayout(
      key: key,
    );
  }
}

class _ExampleLayout extends StatefulWidget {
  const _ExampleLayout({Key? key}) : super(key: key);

  @override
  State<_ExampleLayout> createState() => _ExampleLayoutState();
}

class _ExampleLayoutState extends State<_ExampleLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {

              },
              child: const Text('data'),
          )
        ],
      ),
    );
  }
}

