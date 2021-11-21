import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:gameshow/games/maze/game_logic/player.dart';

import 'maze.dart';

class _info {
  int distance;
  Coordinate? parent;
  bool visited;
  _info(this.distance, this.parent, this.visited);
}

class MazeSolver extends ChangeNotifier {
  MazePlayer _player;
  late Maze _maze;
  late int height;
  late int width;

  MazeSolver(this._player) {
    _maze = _player.maze;
    height = _maze.height;
    width = _maze.width;
    List<List<_info>> mazeInfo = List.generate(
      height,
      (i) => List.generate(
        width,
        (j) => _info(999999, null, false),
      ),
    );
    mazeInfo[_player.i][_player.j].distance = 0;
    PriorityQueue<Coordinate> cola = PriorityQueue<Coordinate>(
      (a, b) => mazeInfo[a.i][a.j].distance - mazeInfo[b.i][b.j].distance,
    );
    cola.add(Coordinate(_player.i, _player.j));
    while (cola.isNotEmpty) {
      Coordinate current = cola.removeFirst();
      mazeInfo[current.i][current.j].visited = true;
      neighbors(current).forEach((neighbor) {
        if (!mazeInfo[neighbor.i][neighbor.j].visited) {
          if (mazeInfo[neighbor.i][neighbor.j].distance >
              mazeInfo[current.i][current.j].distance + 1) {
            mazeInfo[neighbor.i][neighbor.j].distance >
                mazeInfo[current.i][current.j].distance + 1;
            mazeInfo[neighbor.i][neighbor.j].parent = current;
            cola.add(neighbor);
          }
        }
      });
    }
  }

  List<Coordinate> neighbors(Coordinate current) {
    List<Coordinate> neighbors = [];
    if (current.i > 0) {
      neighbors.add(Coordinate(current.i - 1, current.j));
    }
    if (current.i < height - 1) {
      neighbors.add(Coordinate(current.i + 1, current.j));
    }
    if (current.j > 0) {
      neighbors.add(Coordinate(current.i, current.j - 1));
    }
    if (current.j < width - 1) {
      neighbors.add(Coordinate(current.i, current.j + 1));
    }
    return neighbors;
  }
}
