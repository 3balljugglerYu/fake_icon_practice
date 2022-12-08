import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/cupertino.dart';

class Position {
  double x;
  double y;

  static bool isChange = false;
  Position({required this.x, required this.y});

  static void defaultPosition(BuildContext context){
    try {
      Size screenSize;
      screenSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

      Utils.settingPosition = Position(x: screenSize.width / 2 - 30, y: screenSize.height / 3 + 30);

    } catch (e) {
      print('エラー');
      print(e);
    }
  }
}