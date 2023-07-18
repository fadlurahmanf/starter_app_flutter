import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _UnknownLayout(
      key: key,
    );
  }
}

class _UnknownLayout extends StatefulWidget {
  const _UnknownLayout({Key? key}) : super(key: key);

  @override
  State<_UnknownLayout> createState() => _UnknownLayoutState();
}

class _UnknownLayoutState extends State<_UnknownLayout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('UNKNOWN ROUTE'),
      ),
    );
  }
}
