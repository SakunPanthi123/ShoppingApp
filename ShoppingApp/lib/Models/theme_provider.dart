import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppColors extends ChangeNotifier {
  List<Color> appColors = [
    Colors.white,
    Colors.black54,
    Colors.black.withOpacity(.7)
  ];
  bool darkMode = false;
  void changeTheme(bool theme) {
    switch (theme) {
      // 0 index is for background and appbar icons, 1 index is for bottom nav bar icons
      case false:
        // dark mode
        appColors[0] = Colors.black87;
        appColors[1] = Colors.white;
        appColors[2] = Colors.white.withOpacity(.8);

      case true:
        // light mode
        appColors[0] = Colors.white;
        appColors[1] = Colors.black45;
        appColors[2] = Colors.black87;

      default:
        appColors[0] = Colors.white;
        appColors[1] = Colors.black45;
        appColors[2] = Colors.black;
    }
    notifyListeners();
  }

  get getColors => appColors;
}
