import 'package:flutter/material.dart';
import 'package:gameshow/generated/l10n.dart';

import 'gameLogic/game.dart';
import 'gameLogic/players/easyAI.dart';
import 'gameLogic/players/hardAI.dart';
import 'gameLogic/players/mediumAI.dart';
import 'gameLogic/players/player.dart';

class GameBoard extends StatefulWidget {
  GameBoard(this.sizeFactor, {Key? key}) : super(key: key);
  final Game game = Game();
  final double sizeFactor;
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<GameBoard> {
  _BoardState() {
    _selectedDifficulty = S.current.user;
  }
  late List<String> _difficulties = [
    S.of(context).user,
    S.of(context).difficultyEasy,
    S.of(context).difficultyMedium,
    S.of(context).difficultyHard,
  ];
  late String _selectedDifficulty;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final int index = _difficulties.indexOf(_selectedDifficulty);
    _difficulties = [
      S.of(context).user,
      S.of(context).difficultyEasy,
      S.of(context).difficultyMedium,
      S.of(context).difficultyHard,
    ];
    _selectedDifficulty = _difficulties[index];
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            S.current.opponent + ':',
            textScaleFactor: widget.sizeFactor,
          ),
          SizedBox(width: 10 * widget.sizeFactor),
          DropdownButton(
            value: _selectedDifficulty,
            onChanged: widget.game.countSymbols('X') == 0
                ? (String? newValue) {
                    setState(() {
                      _selectedDifficulty = newValue!;
                    });
                  }
                : null,
            items: _difficulties.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
    ]);
  }

  Widget _matrix(Game game) {
    return Column(
      children: [
        Container(
            height: 2 * widget.sizeFactor,
            width: 190 * widget.sizeFactor,
            color: Colors.black),
        SizedBox(height: 5 * widget.sizeFactor, width: 190 * widget.sizeFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MatrixCell(game, 0, 0, widget.sizeFactor, _cellPressed),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _MatrixCell(game, 0, 1, widget.sizeFactor, _cellPressed),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _MatrixCell(game, 0, 2, widget.sizeFactor, _cellPressed),
          ],
        ),
        Container(
            height: 5 * widget.sizeFactor,
            width: 160 * widget.sizeFactor,
            color: Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MatrixCell(game, 1, 0, widget.sizeFactor, _cellPressed),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _MatrixCell(game, 1, 1, widget.sizeFactor, _cellPressed),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _MatrixCell(game, 1, 2, widget.sizeFactor, _cellPressed),
          ],
        ),
        Container(
            height: 5 * widget.sizeFactor,
            width: 160 * widget.sizeFactor,
            color: Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MatrixCell(game, 2, 0, widget.sizeFactor, _cellPressed),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _MatrixCell(game, 2, 1, widget.sizeFactor, _cellPressed),
            Container(
                height: 50 * widget.sizeFactor,
                width: 5 * widget.sizeFactor,
                color: Colors.black),
            _MatrixCell(game, 2, 2, widget.sizeFactor, _cellPressed),
          ],
        ),
        SizedBox(height: 5 * widget.sizeFactor, width: 190 * widget.sizeFactor),
        Container(
            height: 2 * widget.sizeFactor,
            width: 190 * widget.sizeFactor,
            color: Colors.black),
      ],
    );
  }

  void _cellPressed(int i, int j) {
    String nextTurn = widget.game.getTurn();
    if (!widget.game.isFinished && widget.game.positions.getElem(i, j) == '_') {
      setState(() {
        widget.game.positions.setElem(i, j, nextTurn);
      });
      setState(() {
        if (widget.game.spacesLeft() == 0 || widget.game.hasWon(nextTurn)) {
          widget.game.isFinished = true;
        } else {
          nextTurn = widget.game.getTurn();
          if (_selectedDifficulty == S.current.difficultyEasy) {
            Player player = EasyAI(nextTurn);
            player.makeMove(widget.game);
          } else if (_selectedDifficulty == S.current.difficultyMedium) {
            Player player = MediumAI(nextTurn);
            player.makeMove(widget.game);
          } else if (_selectedDifficulty == S.current.difficultyHard) {
            Player player = HardAI(nextTurn);
            player.makeMove(widget.game);
          }
        }
        if (widget.game.spacesLeft() == 0 || widget.game.hasWon(nextTurn)) {
          widget.game.isFinished = true;
        }
      });
    }
  }
}

class _MatrixCell extends StatelessWidget {
  final Game game;
  final int i;
  final int j;
  final double sizeFactor;
  final Function cellPressed;

  const _MatrixCell(
      this.game, this.i, this.j, this.sizeFactor, this.cellPressed);

  @override
  Widget build(BuildContext context) {
    Icon ret = Icon(
      game.positions.getElem(i, j) == 'X'
          ? Icons.dangerous
          : Icons.radio_button_off,
      size: 40 * sizeFactor,
    );
    return InkWell(
        onTap: () => cellPressed(i, j),
        child: SizedBox(
            width: 50 * sizeFactor,
            height: 50 * sizeFactor,
            child: Visibility(
              child: ret,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: game.positions.getElem(i, j) != '_',
            )));
  }
}
