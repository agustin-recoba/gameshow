class Game {
  var positions;
  bool isFinished = false;

  Game([positions, gameCopy]) {
    if (positions == null)
      this.positions =
          List.generate(3, (i) => ['_', '_', '_'], growable: false);
    if (gameCopy != null) {
      for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
          this.positions[i][j] = gameCopy.positions[i][j];
    }
  }

  String getTurn() {
    var p1 = this.countSymbols('X');
    var p2 = this.countSymbols('O');
    return p1 <= p2 ? 'X' : 'O';
  }

  String getString() {
    String out = "";
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        out = out + this.positions[j][i];
      }
    }
    return out;
  }

//no funciona
  bool hasWon(var player) {
    return this.positions[0][0] + this.positions[1][0] + this.positions[2][0] ==
            player * 3 ||
        this.positions[0][1] + this.positions[1][1] + this.positions[2][1] ==
            player * 3 ||
        this.positions[0][2] + this.positions[1][2] + this.positions[2][2] ==
            player * 3 ||
        this.positions[0][0] + this.positions[0][1] + this.positions[0][2] ==
            player * 3 ||
        this.positions[1][0] + this.positions[1][1] + this.positions[1][2] ==
            player * 3 ||
        this.positions[2][0] + this.positions[2][1] + this.positions[2][2] ==
            player * 3 ||
        this.positions[0][0] + this.positions[1][1] + this.positions[2][2] ==
            player * 3 ||
        this.positions[0][2] + this.positions[1][1] + this.positions[2][0] ==
            player * 3;
  }

  int countSymbols(player) {
    int count = 0;
    for (int i = 0; i < 3; i++)
      for (int j = 0; j < 3; j++)
        count += this.positions[i][j] == player ? 1 : 0;
    return count;
  }

  int spacesLeft() {
    int count = 0;
    for (int i = 0; i < 3; i++)
      for (int j = 0; j < 3; j++) count += this.positions[i][j] == '_' ? 1 : 0;
    return count;
  }

  String getState() {
    // returns the state of the match
    if ((this.countSymbols('X') - this.countSymbols('O')).abs() > 1 ||
        (this.hasWon('O') && this.hasWon('X'))) return "Impossible";

    if (this.spacesLeft() > 0 && !this.hasWon('O') && !this.hasWon('X'))
      return "Game not finished";

    if (!(this.spacesLeft() > 0) && !this.hasWon('O') && !this.hasWon('X'))
      return "Draw";

    if (this.hasWon('X')) return "X";
    if (this.hasWon('O')) return "O";

    return "";
  }

  String getEndGame() {
    // returns the state of the match
    if (this.hasWon('X')) return 'X';
    if (this.hasWon('O')) return 'O';
    if (this.spacesLeft() == 0) return 'D';
    return '_';
  }
}
