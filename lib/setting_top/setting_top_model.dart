import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fake_icon_practice/utils.dart';

class SettingTopModel extends ChangeNotifier {
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.backgroundImageFile = File(pickedFile!.path);
    notifyListeners();
  }

  bool tutorialBg = false;
  void tutorialBgChange(){
    tutorialBg = !tutorialBg;
    notifyListeners();
  }

  bool tutorialIcon = false;
  void tutorialIconChange(){
    tutorialIcon = !tutorialIcon;
    notifyListeners();
  }

  bool tutorialSplash = false;
  void tutorialSplashDemo(){
    tutorialSplash = !tutorialSplash;
    notifyListeners();
  }

  void hidePopup() {
    Utils.isSettingTopPagePopupVisible = false;
    showDialog = false;
    notifyListeners();
  }

  late Timer timer;
  bool showDialog = false;

  SettingTopModel() {
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
