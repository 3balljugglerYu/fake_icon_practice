import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fake_icon/utils.dart';

class PerformanceModel extends ChangeNotifier {
  Future<void> onPressed() async {
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    Utils.tutorialCount ++;
    print(Utils.tutorialCount);
  }

  void hidePopup() {
    Utils.isPerformancePagePopupVisible = false;
    showDialog = false;
    notifyListeners();
  }

  late Timer timer;
  bool showDialog = false;

  PerformanceModel() {
    timer = Timer(const Duration(seconds: 1), showAlertDialog);
  }

  void showAlertDialog() {
    showDialog = true;
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

}