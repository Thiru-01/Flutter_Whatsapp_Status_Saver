import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Color mainColor = const Color(0xFFAB8AF7);
  int selected = 0;

  changeHextoRGB(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  changeselect(int value) {
    selected = value;
    notifyListeners();
  }
}
