import 'package:flutter/material.dart';
import 'package:fake_icon_practice/utils.dart';

class PerformanceModel extends ChangeNotifier {
  Future<void> onPressed() async {
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    Utils.tutorialCount ++;
    print(Utils.tutorialCount);
  }
}