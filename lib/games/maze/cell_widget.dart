import 'package:flutter/material.dart';

import 'game_logic/cell.dart';
import 'maze_widget.dart';

class CellWidget extends StatefulWidget {
  final Cell cell;
  final MazeWidget mazeWidget;
  late final BorderSide _borderSideClosed;
  late final Border _border;
  late final BoxDecoration _deco;

  CellWidget(this.cell, this.mazeWidget, {Key? key}) : super(key: key) {
    _borderSideClosed = BorderSide(
      width: mazeWidget.wallThickness,
      color: Colors.black,
    );
    _border = Border(
      top: cell.up ? _borderSideClosed : BorderSide.none,
      bottom: cell.down ? _borderSideClosed : BorderSide.none,
      left: cell.left ? _borderSideClosed : BorderSide.none,
      right: cell.right ? _borderSideClosed : BorderSide.none,
    );
    _deco =
        BoxDecoration(border: _border, color: Colors.black.withOpacity(0.05));
  }

  @override
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.cell,
        builder: (context, child) {
          bool path = widget.cell.hadPlayer;
          bool player = widget.cell.hasPlayer;
          return Container(
            height: widget.mazeWidget.cellSize,
            width: widget.mazeWidget.cellSize,
            child: Icon(Icons.circle,
                size: player
                    ? widget.mazeWidget.cellSize -
                        widget.mazeWidget.wallThickness
                    : widget.mazeWidget.cellSize -
                        2 * widget.mazeWidget.wallThickness,
                color: widget.cell.isStart
                    ? Colors.green
                    : player
                        ? Colors.amber
                        : widget.cell.isEnd
                            ? Colors.red
                            : path
                                ? Colors.amber[100]
                                : Colors.transparent),
            decoration: widget._deco,
          );
        });
  }
}
