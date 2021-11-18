import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  final Widget Function(BuildContext) _builder;

  const AppBuilder(this._builder, {Key? key}) : super(key: key);

  @override
  AppBuilderState createState() => AppBuilderState();

  static AppBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>();
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget._builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}
