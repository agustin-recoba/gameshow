import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'package:gameshow/generated/l10n.dart';

class ExplorerHomeScreen extends StatefulWidget {
  const ExplorerHomeScreen({Key? key}) : super(key: key);

  @override
  _ExplorerHomeScreenState createState() => _ExplorerHomeScreenState();
}

class _ExplorerHomeScreenState extends State<ExplorerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(
          S.of(context).selectGame,
          textScaleFactor: Config.getSizeFactor() * 1.3,
        ),
      ),
      drawer: ConfigDrawer(setState),
    );
  }
}
