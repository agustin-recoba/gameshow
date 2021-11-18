import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'package:gameshow/generated/l10n.dart';
import 'maze_widget.dart';

class MazeHomeScreen extends StatefulWidget {
  MazeHomeScreen({Key? key}) : super(key: key);

  @override
  MazeHomeScreenState createState() => MazeHomeScreenState();
}

class MazeHomeScreenState extends State<MazeHomeScreen> {
  double _baseHorizontalFactor = 1.0;
  double _baseVerticalFactor = 1.0;

  int _mazeHeight = 20;
  int _mazeWidth = 7;
  late MazeWidget maze;

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
      drawer: ConfigDrawer(this.setState),
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(S.of(context).mazeSolver,
            textScaleFactor: Config.getSizeFactor() * 1.2),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              reDrawMaze();
            });
          },
          child: Icon(Icons.refresh)),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
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

              if ((_newHeight * maze.cellSize < constraints.maxHeight) &&
                  _newHeight > 4) {
                _mazeHeight = _newHeight;
              }
              if ((_newWidth * maze.cellSize < constraints.maxWidth) &&
                  _newHeight > 2) {
                _mazeWidth = _newWidth;
              }
              reDrawMazeOutline();
            });
          },
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: maze,
          ),
        ),
      ),
    );
  }
}
