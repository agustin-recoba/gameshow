import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:gameshow/games/maze/game_logic/player.dart';

import 'maze.dart';

class _info {
  int distance;
  Coordinate? parent;
  bool visited;
  _info(this.distance, this.parent, this.visited);
}

class MazeSolver {
  MazePlayer _player;
  late Maze _maze;
  late int height;
  late int width;
  late List<List<_info>> mazeInfo;

  MazeSolver(this._player) {
    _maze = _player.maze;
    height = _maze.height;
    width = _maze.width;
    mazeInfo = List.generate(
      height,
      (_) => List.generate(
        width,
        (__) => _info(999999, null, false),
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
          print(neighbor);
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
    if (current.i > 0 && !_maze.cells[current.i - 1][current.j].up) {
      neighbors.add(Coordinate(current.i - 1, current.j));
    }
    if (current.i < height - 1 && !_maze.cells[current.i - 1][current.j].down) {
      neighbors.add(Coordinate(current.i + 1, current.j));
    }
    if (current.j > 0 && !_maze.cells[current.i - 1][current.j].left) {
      neighbors.add(Coordinate(current.i, current.j - 1));
    }
    if (current.j < width - 1 && !_maze.cells[current.i - 1][current.j].right) {
      neighbors.add(Coordinate(current.i, current.j + 1));
    }
    return neighbors;
  }

  List<Coordinate> getPath() {
    Queue<Coordinate> path = Queue<Coordinate>();
    Coordinate? current = Coordinate(_maze.end_i, _maze.end_j);
    while (current != null) {
      path.addFirst(current);
      current = mazeInfo[current.i][current.j].parent;
    }
    return path.toList();
  }

  void makePlayerFollowPath({Duration? durationBetweenSteps}) {
    List<Coordinate> path = getPath();
    for (int i = 1; i < path.length; i++) {
      _player.moveTo(path[i - 1].i, path[i - 1].j);
    }
  }
}
