import 'package:flutter/foundation.dart';
import '../game.dart';
import 'easyAI.dart';
import 'player.dart';

class mediumAI extends Player {
  mediumAI(String symbol) : super(symbol);

  void makeMove(Game game) {
    List<List<List<int>>> possibleLines = [
      [
        [0, 0],
        [1, 0],
        [2, 0]
      ],
      [
        [0, 1],
        [1, 1],
        [2, 1]
      ],
      [
        [0, 2],
        [1, 2],
        [2, 2]
      ],
      [
        [0, 0],
        [0, 1],
        [0, 2]
      ],
      [
        [1, 0],
        [1, 1],
        [1, 2]
      ],
      [
        [2, 0],
        [2, 1],
        [2, 2]
      ],
      [
        [0, 0],
        [1, 1],
        [2, 2]
      ],
      [
        [0, 2],
        [1, 1],
        [2, 0]
      ]
    ];

    String player = this.getSymbol();

    if (this.possibleWin(game)) {
      for (int i = 0; i < 8; i++) {
        if (this.possibleWinningLine(game, possibleLines[i])) {
          for (int j = 0; j < 3; j++) {
            if (game.positions[possibleLines[i][j][0]]
                    [possibleLines[i][j][1]] ==
                '_') {
              game.positions[possibleLines[i][j][0]][possibleLines[i][j][1]] =
                  player;
            }
          }
          break;
        }
      }
    } else if (this.possibleLoss(game)) {
      print('a');
      for (int i = 0; i < 8; i++) {
        if (this.possibleLosingLine(game, possibleLines[i])) {
          for (int j = 0; j < 3; j++) {
            if (game.positions[possibleLines[i][j][0]]
                    [possibleLines[i][j][1]] ==
                '_') {
              game.positions[possibleLines[i][j][0]][possibleLines[i][j][1]] =
                  player;
            }
          }
          break;
        }
      }
    } else {
      easyAI easy = new easyAI(this.getSymbol());
      easy.makeMove(game);
    }
  }

  bool equalMultiSet(List<String> a, List<String> b) {
    a.sort();
    b.sort();
    return listEquals(a, b);
  }

  bool possibleWin(Game game) {
    List<String> win = [this.getSymbol(), this.getSymbol(), '_'];
    return equalMultiSet(
            [game.positions[0][0], game.positions[1][0], game.positions[2][0]],
            win) ||
        equalMultiSet(
            [game.positions[0][1], game.positions[1][1], game.positions[2][1]],
            win) ||
        equalMultiSet(
            [game.positions[0][2], game.positions[1][2], game.positions[2][2]],
            win) ||
        equalMultiSet(
            [game.positions[0][0], game.positions[0][1], game.positions[0][2]],
            win) ||
        equalMultiSet(
            [game.positions[1][0], game.positions[1][1], game.positions[1][2]],
            win) ||
        equalMultiSet(
            [game.positions[2][0], game.positions[2][1], game.positions[2][2]],
            win) ||
        equalMultiSet(
            [game.positions[0][0], game.positions[1][1], game.positions[2][2]],
            win) ||
        equalMultiSet(
            [game.positions[0][2], game.positions[1][1], game.positions[2][0]],
            win);
  }

  bool possibleLoss(Game game) {
    String player = this.getSymbol() == 'X' ? 'O' : 'X';
    List<String> win = [player, player, '_'];
    return equalMultiSet(
            [game.positions[0][0], game.positions[1][0], game.positions[2][0]],
            win) ||
        equalMultiSet(
            [game.positions[0][1], game.positions[1][1], game.positions[2][1]],
            win) ||
        equalMultiSet(
            [game.positions[0][2], game.positions[1][2], game.positions[2][2]],
            win) ||
        equalMultiSet(
            [game.positions[0][0], game.positions[0][1], game.positions[0][2]],
            win) ||
        equalMultiSet(
            [game.positions[1][0], game.positions[1][1], game.positions[1][2]],
            win) ||
        equalMultiSet(
            [game.positions[2][0], game.positions[2][1], game.positions[2][2]],
            win) ||
        equalMultiSet(
            [game.positions[0][0], game.positions[1][1], game.positions[2][2]],
            win) ||
        equalMultiSet(
            [game.positions[0][2], game.positions[1][1], game.positions[2][0]],
            win);
  }

  bool possibleWinningLine(Game game, List<List<int>> line) {
    return equalMultiSet([
      game.positions[line[0][0]][line[0][1]],
      game.positions[line[1][0]][line[1][1]],
      game.positions[line[2][0]][line[2][1]]
    ], [
      this.getSymbol(),
      this.getSymbol(),
      '_'
    ]);
  }

  bool possibleLosingLine(Game game, List<List<int>> line) {
    String player = this.getSymbol() == 'X' ? 'O' : 'X';
    return equalMultiSet([
      game.positions[line[0][0]][line[0][1]],
      game.positions[line[1][0]][line[1][1]],
      game.positions[line[2][0]][line[2][1]]
    ], [
      player,
      player,
      '_'
    ]);
  }
}
