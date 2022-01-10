import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'package:gameshow/generated/l10n.dart';
import 'maze_widget.dart';

class MazeHomeScreen extends StatefulWidget {
  const MazeHomeScreen({Key? key}) : super(key: key);

  @override
  MazeHomeScreenState createState() => MazeHomeScreenState();
}

class MazeHomeScreenState extends State<MazeHomeScreen> {
  double _baseHorizontalFactor = 1.0;
  double _baseVerticalFactor = 1.0;

  final ValueNotifier _constraintsUpdated = ValueNotifier(false);

  int _mazeHeight = 20;
  int _maxMazeHeight = 20;
  int _mazeWidth = 7;
  int _maxMazeWidth = 7;
  late MazeWidget maze;

  @override
  void initState() {
    super.initState();
    reDrawMaze();
  }

  void reDrawMaze() {
    maze = MazeWidget(_mazeHeight, _mazeWidth);
    maze.maze.generateMaze();
  }

  void reDrawMazeOutline() {
    maze = MazeWidget(_mazeHeight, _mazeWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ConfigDrawer(setState,
          pageSpecificSettings: mazeSolverSettings(context)),
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(S.of(context).mazeSolver,
            textScaleFactor: Config.getSizeFactor() * 1.2),
      ),
      body: Stack(children: [
        LayoutBuilder(
          builder: (context, constraints) {
            _maxMazeHeight = constraints.maxHeight ~/ maze.cellSize;
            _maxMazeWidth = constraints.maxWidth ~/ maze.cellSize;
            _constraintsUpdated.value = true;
            return GestureDetector(
              onScaleStart: (details) {
                _baseHorizontalFactor = _mazeWidth * 1.0;
                _baseVerticalFactor = _mazeHeight * 1.0;
              },
              onScaleEnd: (_) {
                reDrawMaze();
              },
              onScaleUpdate: (details) {
                setState(() {
                  int _newHeight =
                      (_baseVerticalFactor * details.verticalScale).floor();
                  int _newWidth =
                      (_baseHorizontalFactor * details.horizontalScale).floor();

                  if ((_newHeight <= _maxMazeHeight) && _newHeight > 4) {
                    _mazeHeight = _newHeight;
                  }
                  if ((_newWidth <= _maxMazeWidth) && _newHeight > 2) {
                    _mazeWidth = _newWidth;
                  }
                  reDrawMazeOutline();
                });
              },
              child: SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: maze,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      setState(() {
                        reDrawMaze();
                      });
                    },
                    child: const Icon(Icons.refresh)),
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    maze.maze.solveMaze();
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  List<Widget> mazeSolverSettings(BuildContext context) {
    return [
      Text(S.of(context).mazeHeight + ': '),
      AnimatedBuilder(
          animation: _constraintsUpdated,
          builder: (_, __) => Slider(
                value: _mazeHeight.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _mazeHeight = value.toInt();
                    reDrawMazeOutline();
                  });
                },
                onChangeEnd: (value) {
                  reDrawMaze();
                },
                min: 5,
                max: _maxMazeHeight.toDouble(),
              )),
      Text(S.of(context).mazeWidth + ': '),
      AnimatedBuilder(
          animation: _constraintsUpdated,
          builder: (_, __) => Slider(
                value: _mazeWidth.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _mazeWidth = value.toInt();
                    reDrawMazeOutline();
                  });
                },
                onChangeEnd: (value) {
                  reDrawMaze();
                },
                min: 5,
                max: _maxMazeWidth.toDouble(),
              )),
    ];
  }
}
