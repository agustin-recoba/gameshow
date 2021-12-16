// ignore_for_file: camel_case_types, file_names

import 'dart:math';

import '../game.dart';
import 'player.dart';

class HardAI extends Player {
  HardAI(String symbol) : super(symbol);

  @override
  void makeMove(Game game) {
    int bestScore = -10000;
    List<int> bestMove = [1, 1];
    int score;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (game.positions.getElem(i, j) == '_') {
          game.positions.setElem(i, j, getSymbol());
          score = minimax(game, getSymbol(), false, 0);
          game.positions.setElem(i, j, '_');
          if (score > bestScore) {
            bestScore = score;
            bestMove[0] = i;
            bestMove[1] = j;
          }
        }
      }
    }
    game.positions.setElem(bestMove[0], bestMove[1], getSymbol());
  }

  int minimax(Game game, String player, bool isMaximizing, int depth) {
    if (game.getEndGame() == 'D') {
      return 0;
    } else if (game.getEndGame() == player) {
      return 10;
    } else if (game.getEndGame() == (player == 'X' ? 'O' : 'X')) {
      return -10;
    }

    if (isMaximizing) {
      int bestScore = -100;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (game.positions[i][j] == '_') {
            game.positions.setElem(i, j, player);
            int score = minimax(game, player, false, depth + 1);
            game.positions.setElem(i, j, '_');
            bestScore = max(score, bestScore);
          }
        }
      }
      return bestScore;
    } else {
      String opposite = player == 'X' ? 'O' : 'X';
      int worstScore = 100;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (game.positions[i][j] == '_') {
            game.positions.setElem(i, j, opposite);
            int score = minimax(game, player, true, depth + 1);
            game.positions.setElem(i, j, '_');
            worstScore = min(score, worstScore);
          }
        }
      }
      return worstScore;
    }
  }
}
