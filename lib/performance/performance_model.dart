import 'package:flutter/material.dart';

class PerformanceModel extends ChangeNotifier {
  Future<void> onPressed() async {
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
  }
}