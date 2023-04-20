import 'package:flutter/material.dart';
import 'package:fake_icon/position_model.dart';

class SettingPutIconModel extends ChangeNotifier {
  Size? displaySize;
  late Size displayMaxSafeArea = Size(displaySize!.width - 5, displaySize!.height - 10);
  late Size displayMinSafeArea = const Size(5, 40);

  void dragEnd(dragDetails, Position position) {
    if(displayMaxSafeArea.width < dragDetails.offset.dx + 65
        || displayMaxSafeArea.height < dragDetails.offset.dy + 65
        || displayMinSafeArea.width > dragDetails.offset.dx
        || displayMinSafeArea.height > dragDetails.offset.dy
    ){
      position.x = displaySize!.width * 0.5 - 30;
      position.y = displaySize!.height * 0.5 - 30;
    } else {
      position.x = dragDetails.offset.dx;
      position.y = dragDetails.offset.dy;
    }
    Position.isChange = true;
    notifyListeners();
  }
}

