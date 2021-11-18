import 'package:flutter/material.dart';
import 'package:gameshow/generated/l10n.dart';

import 'gameLogic/game.dart';
import 'gameLogic/players/easyAI.dart';
import 'gameLogic/players/hardAI.dart';
import 'gameLogic/players/mediumAI.dart';
import 'gameLogic/players/player.dart';

class GameBoard extends StatefulWidget {
  GameBoard(this.sizeFactor, {Key? key}) : super(key: key);
  Game game = Game();
  double sizeFactor;
  @override
  _boardState createState() => _boardState();
}

class _boardState extends State<GameBoard> {
  _boardState() {
    _difficulties = [
      S.current.user,
      S.current.difficultyEasy,
      S.current.difficultyMedium,
      S.current.difficultyHard,
    ];
    _selectedDifficulty = S.current.user;
  }
  late List<String> _difficulties;
  late String _selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Ink(
        child: Column(children: [
      Text(
        S.current.board + ':',
        textScaleFactor: 1.5 * widget.sizeFactor,
      ),
      _matrix(widget.game),
      SizedBox(
        height: 10 * widget.sizeFactor,
      ),
      Text(
        S.current.turnText(widget.game.getTurn()),
        textScaleFactor: 1.2 * widget.sizeFactor,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.current.oponent + ':',
            textScaleFactor: widget.sizeFactor,
          ),
          SizedBox(width: 10 * widget.sizeFactor),
          DropdownButton(
            value: _selectedDifficulty,
            onChanged: (String? newValue) {
              setState(() {
                _selectedDifficulty = newValue!;
              });
            },
            items: _difficulties.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: widget.sizeFactor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      Visibility(
        child: Text(
          widget.game.getState() == 'Draw'
              ? S.current.draw
              : S.current.whoWins(widget.game.getState()),
          textScaleFactor: widget.sizeFactor,
        ),
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        visible: widget.game.isFinished,
      )
    ]));
  }

  Widget _matrix(Game game) {
    return Container(
      child: Column(children: [
        Container(
            height: 2 * widget.sizeFactor,
            width: 190 * widget.sizeFactor,
            color: Colors.black),
        Container(
            height: 5 * widget.sizeFactor, width: 190 * widget.sizeFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _matrixCell(game, 0, 0),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _matrixCell(game, 0, 1),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _matrixCell(game, 0, 2),
          ],
        ),
        Container(
            height: 5 * widget.sizeFactor,
            width: 160 * widget.sizeFactor,
            color: Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _matrixCell(game, 1, 0),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _matrixCell(game, 1, 1),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _matrixCell(game, 1, 2),
          ],
        ),
        Container(
            height: 5 * widget.sizeFactor,
            width: 160 * widget.sizeFactor,
            color: Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _matrixCell(game, 2, 0),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _matrixCell(game, 2, 1),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _matrixCell(game, 2, 2),
          ],
        ),
        Container(
            height: 5 * widget.sizeFactor, width: 190 * widget.sizeFactor),
        Container(
            height: 2 * widget.sizeFactor,
            width: 190 * widget.sizeFactor,
            color: Colors.black),
      ]),
    );
  }

  void _cellPressed(int i, int j) {
    String nextTurn = widget.game.getTurn();
    if (!widget.game.isFinished && widget.game.positions[i][j] == '_') {
      setState(() {
        widget.game.positions[i][j] = nextTurn;
      });
      setState(() {
        if (widget.game.spacesLeft() == 0 || widget.game.hasWon(nextTurn)) {
          widget.game.isFinished = true;
        } else {
          nextTurn = widget.game.getTurn();
          if (_selectedDifficulty == S.current.difficultyEasy) {
            Player player = easyAI(nextTurn);
            player.makeMove(widget.game);
          } else if (_selectedDifficulty == S.current.difficultyMedium) {
            Player player = mediumAI(nextTurn);
            player.makeMove(widget.game);
          } else if (_selectedDifficulty == S.current.difficultyHard) {
            Player player = hardAI(nextTurn);
            player.makeMove(widget.game);
          }
        }
        if (widget.game.spacesLeft() == 0 || widget.game.hasWon(nextTurn)) {
          widget.game.isFinished = true;
        }
      });
    }
  }

  Widget celdaIJ(int i, int j) {
    Icon ret = Icon(
      widget.game.positions[i][j] == 'X'
          ? Icons.dangerous
          : Icons.radio_button_off,
      size: 40 * widget.sizeFactor,
    );
    return Visibility(
      child: ret,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: widget.game.positions[i][j] != '_',
    );
  }

  Widget _matrixCell(Game game, int i, int j) {
    return InkWell(
      onTap: () => _cellPressed(i, j),
      child: Container(
          width: 50 * widget.sizeFactor,
          height: 50 * widget.sizeFactor,
          child: celdaIJ(i, j)),
    );
  }
}
