import '../game.dart';

abstract class Player {
  String sym;
  Player(this.sym);

  String getSymbol() {
    return sym;
  }

  void makeMove(Game game);
}
