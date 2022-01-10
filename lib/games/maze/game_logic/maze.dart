// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:gameshow/helper_classes/matrix.dart';

import 'cell.dart';
import 'player.dart';

class Coordinate {
  int x, y;
  Coordinate(this.x, this.y);

  get i => x;

  get j => y;

  @override
  bool operator ==(Object other) =>
      other is Coordinate && x == other.x && y == other.y;

  @override
  int get hashCode => super.hashCode + x + y;

  @override
  String toString() => '($x, $y)';
}

class Maze {
  int height, width;
  ValueNotifier<bool> compleated = ValueNotifier(false);

  late Matrix<Cell> cells;
  late MazePlayer player;
  late int start_i;
  late int start_j;
  late int end_i;
  late int end_j;

  Maze(this.height, this.width) {
    cells = Matrix(
        height,
        width,
        (i, j) => Cell(
              i == 0 ? true : false,
              i == height - 1 ? true : false,
              j == 0 ? true : false,
              j == width - 1 ? true : false,
            ));
    end_i = Random().nextInt(height);
    end_j = Random().nextInt(width);
    start_i = Random().nextInt(height);
    start_j = Random().nextInt(width);
    player = MazePlayer(start_i, start_j, end_i, end_j, this);
  }

  void reset() {
    compleated.value = false;
    cells = Matrix(
        height,
        width,
        (i, j) => Cell(
              i == 0 ? true : false,
              i == height - 1 ? true : false,
              j == 0 ? true : false,
              j == width - 1 ? true : false,
            ));
    end_i = Random().nextInt(height);
    end_j = Random().nextInt(width);
    start_i = Random().nextInt(height);
    start_j = Random().nextInt(width);
    player = MazePlayer(start_i, start_j, end_i, end_j, this);
  }

  void generateMaze() {
    build(0, height - 1, 0, width - 1);

    cells.getElem(start_i, start_j).setStart(true);
    cells.getElem(start_i, start_j).setHasPlayer(true);
    cells.getElem(start_i, start_j).setHadPlayer(true);
    cells.getElem(end_i, end_j).setEnd(true);
    compleated.value = true;
  }

  int randomInterval(int min, int max) {
    Random _random = Random();
    return max - min <= 0 ? max : min + _random.nextInt(max - min);
  }

  void build(int rowStart, int rowEnd, int colStart, int colEnd) {
    if ((rowEnd - rowStart) < 1 || (colEnd - colStart) < 1) return;

    //random number betwen rowStart (inc) and rowEnd(exc)
    int horizontalLine = randomInterval(rowStart, rowEnd);
    //random number betwen colStart (inc) and colEnd(exc)
    int verticalLine = randomInterval(colStart, colEnd);

    // draw line
    for (int j = colStart; j <= colEnd; j++) {
      setWallDown(horizontalLine, j);
    }
    for (int j = rowStart; j <= rowEnd; j++) {
      setWallRigth(j, verticalLine);
    }
    // create an opening in 3 of 4 walls and recursivelly call in all 4 sections
    int whichNot = randomInterval(0, 4);
    int opening;

    //left
    if (whichNot != 0) {
      opening = randomInterval(colStart, verticalLine);
      deleteWallDown(horizontalLine, opening);
    }
    //rigth
    if (whichNot != 1) {
      opening = randomInterval(verticalLine + 1, colEnd);
      deleteWallDown(horizontalLine, opening);
    }
    //upper
    if (whichNot != 2) {
      opening = randomInterval(rowStart, horizontalLine);
      deleteWallRigth(opening, verticalLine);
    }
    //down
    if (whichNot != 3) {
      opening = randomInterval(horizontalLine + 1, rowEnd);
      deleteWallRigth(opening, verticalLine);
    }

    build(
      rowStart,
      horizontalLine,
      colStart,
      verticalLine,
    );
    build(
      horizontalLine + 1,
      rowEnd,
      colStart,
      verticalLine,
    );
    build(
      rowStart,
      horizontalLine,
      verticalLine + 1,
      colEnd,
    );
    build(
      horizontalLine + 1,
      rowEnd,
      verticalLine + 1,
      colEnd,
    );
  }

  Maze cleanCopy() {
    Maze maze = Maze(height, width);
    maze.cells = Matrix(
        height,
        width,
        (i, j) => Cell(
              i == 0 ? true : false,
              i == height - 1 ? true : false,
              j == 0 ? true : false,
              j == width - 1 ? true : false,
            ));
    maze.compleated = compleated;
    return maze;
  }

  void setWallUp(int i, int j) {
    cells.getElem(i, j).setUp(true);
    if (i >= 1) cells.getElem(i - 1, j).setDown(true);
  }

  void deleteWallUp(int i, int j) {
    cells.getElem(i, j).setUp(false);
    if (i >= 1) cells.getElem(i - 1, j).setDown(false);
  }

  void setWallDown(int i, int j) {
    cells.getElem(i, j).setDown(true);
    if (i < height - 1) cells.getElem(i + 1, j).setUp(true);
  }

  void deleteWallDown(int i, int j) {
    cells.getElem(i, j).setDown(false);
    if (i < height - 1) cells.getElem(i + 1, j).setUp(false);
  }

  void setWallLeft(int i, int j) {
    cells.getElem(i, j).setLeft(true);
    if (j >= 1) cells.getElem(i, j - 1).setRight(true);
  }

  void deleteWallLeft(int i, int j) {
    cells.getElem(i, j).setLeft(false);
    if (j >= 1) cells.getElem(i, j - 1).setRight(false);
  }

  void setWallRigth(int i, int j) {
    cells.getElem(i, j).setRight(true);
    if (j <= width - 1) cells.getElem(i, j + 1).setLeft(true);
  }

  void deleteWallRigth(int i, int j) {
    cells.getElem(i, j).setRight(false);
    if (j <= width - 1) cells.getElem(i, j + 1).setLeft(false);
  }

  void solveMaze() async {
    if (compleated.value && !player.solved) {
      Matrix<_Info> mazeInfo =
          Matrix(height, width, (_, __) => _Info(999999, null, false));
      mazeInfo.getElem(player.i, player.j).distance = 0;
      PriorityQueue<Coordinate> priQueue = PriorityQueue<Coordinate>(
        (a, b) =>
            mazeInfo.getElem(a.i, a.j).distance -
            mazeInfo.getElem(b.i, b.j).distance,
      );
      priQueue.add(Coordinate(player.i, player.j));
      while (priQueue.isNotEmpty) {
        Coordinate u = priQueue.removeFirst();
        mazeInfo.getElem(u.i, u.j).visited = true;
        neighbors(u).forEach((v) {
          if (!mazeInfo.getElem(v.i, v.j).visited) {
            if (mazeInfo.getElem(v.i, v.j).distance >
                mazeInfo.getElem(u.i, u.j).distance + 1) {
              mazeInfo.getElem(v.i, v.j).distance =
                  mazeInfo.getElem(u.i, u.j).distance + 1;
              mazeInfo.getElem(v.i, v.j).parent = u;
              priQueue.add(v);
            }
          }
        });
      }
      Queue<Coordinate> path = Queue<Coordinate>();
      Coordinate? current = Coordinate(end_i, end_j);

      while (current != null) {
        path.addFirst(current);
        current = mazeInfo.getElem(current.i, current.j).parent;
      }

      int time = path.length * 10;

      while (path.isNotEmpty) {
        await Future.delayed(Duration(microseconds: time), () {
          Coordinate pos = path.removeFirst();
          player.moveTo(pos.i, pos.j);
        });
      }
    }
  }

  List<Coordinate> neighbors(Coordinate current) {
    List<Coordinate> neighbors = [];
    if (!cells.getElem(current.i, current.j).up) {
      neighbors.add(Coordinate(current.i - 1, current.j));
    }
    if (!cells.getElem(current.i, current.j).down) {
      neighbors.add(Coordinate(current.i + 1, current.j));
    }
    if (!cells.getElem(current.i, current.j).left) {
      neighbors.add(Coordinate(current.i, current.j - 1));
    }
    if (!cells.getElem(current.i, current.j).right) {
      neighbors.add(Coordinate(current.i, current.j + 1));
    }
    return neighbors;
  }
}

class _Info {
  int distance;
  Coordinate? parent;
  bool visited;
  _Info(this.distance, this.parent, this.visited);
}
