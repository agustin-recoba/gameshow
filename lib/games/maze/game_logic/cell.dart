import 'package:flutter/material.dart';

class Cell extends ChangeNotifier {
  bool up, down, left, right; //true = there is a wall
  bool isStart = false, isEnd = false;
  bool hasPlayer = false;
  bool hadPlayer = false;

  Cell(this.up, this.down, this.left, this.right);

  void setStart(bool val) {
    isStart = val;
    notifyListeners();
  }

  void setEnd(bool val) {
    isEnd = val;
    notifyListeners();
  }

  void setHasPlayer(bool val) {
    hasPlayer = val;
    notifyListeners();
  }

  void setHadPlayer(bool val) {
    hadPlayer = val;
    notifyListeners();
  }

  void setUp(bool val) {
    up = val;
  }

  void setDown(bool val) {
    down = val;
  }

  void setLeft(bool val) {
    left = val;
  }

  void setRight(bool val) {
    right = val;
  }
}
