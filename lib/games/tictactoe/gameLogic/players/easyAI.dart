import 'dart:math';

import '../game.dart';
import 'player.dart';

class easyAI extends Player {
  easyAI(String symbol) : super(symbol);

  void makeMove(Game game) {
    Random rand = new Random();
    int x = rand.nextInt(3) + 1;
    int y = rand.nextInt(3) + 1;
    while (game.positions[y - 1][x - 1] != '_') {
      x = rand.nextInt(3) + 1;
      y = rand.nextInt(3) + 1;
    }
    game.positions[y - 1][x - 1] = this.getSymbol();
  }
}
