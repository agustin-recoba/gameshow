import 'package:gameshow/helper_classes/matrix.dart';

class Game {
  late Matrix<String> positions;
  bool isFinished = false;

  Game([positions, gameCopy]) {
    if (positions == null) {
      this.positions = Matrix(3, 3, (i, j) => '_');
    }
    if (gameCopy != null) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          this.positions.setElem(i, j, gameCopy.positions.getElem(i, j));
        }
      }
    }
  }

  String getTurn() {
    var p1 = countSymbols('X');
    var p2 = countSymbols('O');
    return p1 <= p2 ? 'X' : 'O';
  }

  String getString() {
    String out = "";
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        out = out + positions.getElem(i, j);
      }
    }
    return out;
  }

  bool hasWon(var player) {
    return positions.getElem(0, 0) +
                positions.getElem(1, 0) +
                positions.getElem(2, 0) ==
            player * 3 ||
        positions.getElem(0, 1) +
                positions.getElem(1, 1) +
                positions.getElem(2, 1) ==
            player * 3 ||
        positions.getElem(0, 2) +
                positions.getElem(1, 2) +
                positions.getElem(2, 2) ==
            player * 3 ||
        positions.getElem(0, 1) +
                positions.getElem(0, 1) +
                positions.getElem(0, 2) ==
            player * 3 ||
        positions.getElem(1, 0) +
                positions.getElem(1, 1) +
                positions.getElem(1, 2) ==
            player * 3 ||
        positions.getElem(2, 0) +
                positions.getElem(2, 1) +
                positions.getElem(2, 2) ==
            player * 3 ||
        positions.getElem(0, 0) +
                positions.getElem(1, 1) +
                positions.getElem(2, 2) ==
            player * 3 ||
        positions.getElem(0, 2) +
                positions.getElem(1, 1) +
                positions.getElem(2, 0) ==
            player * 3;
  }

  int countSymbols(player) {
    int count = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        count += positions.getElem(i, j) == player ? 1 : 0;
      }
    }
    return count;
  }

  int spacesLeft() {
    int count = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        count += positions.getElem(i, j) == '_' ? 1 : 0;
      }
    }
    return count;
  }

  String getState() {
    // returns the state of the match
    if ((countSymbols('X') - countSymbols('O')).abs() > 1 ||
        (hasWon('O') && hasWon('X'))) return "Impossible";

    if (spacesLeft() > 0 && !hasWon('O') && !hasWon('X')) {
      return "Game not finished";
    }

    if (!(spacesLeft() > 0) && !hasWon('O') && !hasWon('X')) {
      return "Draw";
    }

    if (hasWon('X')) return "X";
    if (hasWon('O')) return "O";

    return "";
  }

  String getEndGame() {
    // returns the state of the match
    if (hasWon('X')) return 'X';
    if (hasWon('O')) return 'O';
    if (spacesLeft() == 0) return 'D';
    return '_';
  }
}
