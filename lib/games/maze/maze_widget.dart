import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';

import 'cell_widget.dart';
import 'game_logic/maze.dart';

class MazeWidget extends StatefulWidget {
  final int height;
  final int width;

  late final Maze maze;
  late final double _sizeFactor;

  late final double cellSize;
  late final double wallThikness;
  late final double totalHeight, totalWidth;

  MazeWidget(this.height, this.width, {Key? key}) : super(key: key) {
    maze = Maze(height, width);
    _sizeFactor = Config.getSizeFactor();
    cellSize = _sizeFactor * 15.0;
    wallThikness = cellSize * 0.1;
    totalHeight = maze.height * cellSize;
    totalWidth = maze.width * cellSize;
  }

  @override
  _MazeWidgetState createState() => _MazeWidgetState();
}

class _MazeWidgetState extends State<MazeWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          if (!widget.maze.compleated.value) {
            widget.maze.generateMaze();
          }
        },
        onVerticalDragEnd: (details) {
          if (widget.maze.compleated.value &&
              !widget.maze.player.solved &&
              widget.maze.compleated.value &&
              details.primaryVelocity! < 0)
            widget.maze.player.moveUp();
          else if (widget.maze.compleated.value &&
              !widget.maze.player.solved &&
              widget.maze.compleated.value &&
              details.primaryVelocity! > 0) widget.maze.player.moveDown();
        },
        onHorizontalDragEnd: (details) {
          if (widget.maze.compleated.value &&
              !widget.maze.player.solved &&
              widget.maze.compleated.value &&
              details.primaryVelocity! > 0)
            widget.maze.player.moveRigth();
          else if (widget.maze.compleated.value &&
              !widget.maze.player.solved &&
              widget.maze.compleated.value &&
              details.primaryVelocity! < 0) widget.maze.player.moveLeft();
        },
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: widget.maze.player,
                builder: (_, __) {
                  return Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    color: widget.maze.compleated.value &&
                            widget.maze.player.solved
                        ? Colors.green.withOpacity(0.3)
                        : Colors.transparent,
                  );
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.height; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < widget.width; j++)
                        CellWidget(widget.maze.cells[i][j], widget),
                    ],
                  )
              ],
            ),
          ],
        ),
      );
    });
  }
}
