// ignore_for_file: file_names

import 'dart:math';

import '../game.dart';
import 'player.dart';

class EasyAI extends Player {
  EasyAI(String symbol) : super(symbol);

  @override
  void makeMove(Game game) {
    Random rand = Random();
    int x = rand.nextInt(3) + 1;
    int y = rand.nextInt(3) + 1;
    while (game.positions.getElem(y - 1, x - 1) != '_') {
      x = rand.nextInt(3) + 1;
      y = rand.nextInt(3) + 1;
    }
    game.positions.setElem(y - 1, x - 1, getSymbol());
  }
}
