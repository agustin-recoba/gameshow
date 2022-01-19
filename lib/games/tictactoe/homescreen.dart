import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'package:gameshow/generated/l10n.dart';
import 'board.dart';

class TictactoeHomeScreen extends StatefulWidget {
  const TictactoeHomeScreen({Key? key}) : super(key: key);

  @override
  TictactoeHomeScreenState createState() => TictactoeHomeScreenState();
}

class TictactoeHomeScreenState extends State<TictactoeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ConfigDrawer(setState),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh)),
      body: Center(
        child: GameBoard(Config.getSizeFactor() * 2),
      ),
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(S.of(context).TicTacToe,
            textScaleFactor: Config.getSizeFactor() * 1.2),
      ),
    );
  }
}
