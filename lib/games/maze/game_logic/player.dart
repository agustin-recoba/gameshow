import 'package:flutter/material.dart';

import 'maze.dart';

class MazePlayer extends ChangeNotifier {
  int i, j;
  bool solved = false;
  Maze maze;
  late int start_i, start_j;
  late int end_i, end_j;

  late List<Coordinate> path;

  MazePlayer(this.i, this.j, this.end_i, this.end_j, this.maze) {
    path = [];
  }

  bool canMoveUp() {
    return !maze.cells[i][j].up;
  }

  bool canMoveDown() {
    return !maze.cells[i][j].down;
  }

  bool canMoveLeft() {
    return !maze.cells[i][j].left;
  }

  bool canMoveRight() {
    return !maze.cells[i][j].right;
  }

  void updateSolvedAndPath() {
    solved = end_j == j && end_i == i;
    if (solved) {
      path.add(Coordinate(i, j));
      notifyListeners();
    }
  }

  void moveDown() {
    if (canMoveDown()) {
      path.add(Coordinate(i, j));
      maze.cells[i][j].setHasPlayer(false);
      i++;
      maze.cells[i][j].setHasPlayer(true);
      maze.cells[i][j].setHadPlayer(true);
      updateSolvedAndPath();
    }
  }

  void moveUp() {
    if (canMoveUp()) {
      path.add(Coordinate(i, j));
      maze.cells[i][j].setHasPlayer(false);
      i--;
      maze.cells[i][j].setHasPlayer(true);
      maze.cells[i][j].setHadPlayer(true);
      updateSolvedAndPath();
    }
  }

  void moveLeft() {
    if (canMoveLeft()) {
      path.add(Coordinate(i, j));
      maze.cells[i][j].setHasPlayer(false);
      j--;
      maze.cells[i][j].setHasPlayer(true);
      maze.cells[i][j].setHadPlayer(true);
      updateSolvedAndPath();
    }
  }

  void moveRigth() {
    if (canMoveRight()) {
      path.add(Coordinate(i, j));
      maze.cells[i][j].setHasPlayer(false);
      j++;
      maze.cells[i][j].setHasPlayer(true);
      maze.cells[i][j].setHadPlayer(true);
      updateSolvedAndPath();
    }
  }

  void moveTo(int i, int j) {
    path.add(Coordinate(this.i, this.j));
    maze.cells[this.i][this.j].setHasPlayer(false);
    this.i = i;
    this.j = j;
    maze.cells[this.i][this.j].setHasPlayer(true);
    maze.cells[this.i][this.j].setHadPlayer(true);
    updateSolvedAndPath();
  }
}
