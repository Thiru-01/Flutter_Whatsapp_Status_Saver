import 'package:flutter/cupertino.dart';

class BottomBarProvider with ChangeNotifier {
  int state = 0;
  changestate(int value) {
    state = value;
    notifyListeners();
  }
}
