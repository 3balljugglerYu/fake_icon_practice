import 'package:flutter/material.dart';
import 'package:fake_icon_practice/position_model.dart';

class SettingPutIconModel extends ChangeNotifier {
  Size? displaySize;

  void dragEnd(dragDetails, Position position) {
    position.x = dragDetails.offset.dx;
    position.y = dragDetails.offset.dy;
    notifyListeners();
  }
}

