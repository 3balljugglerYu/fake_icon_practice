import 'dart:io';

import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SettingSplashModel extends ChangeNotifier {
  // late SharedPreferences prefs;

  final frequencyNum = List.generate(11, (index) => "$index");
  final comebackLogoSec = List.generate(61, (index) => "$index");
  final transitionSec = List.generate(61, (index) => "$index");
  final setUpSec = List.generate(11, (index) => "$index");

  List<Center> freNum = [];
  List<Center> comSec = [];
  List<Center> traSec = [];
  List<Center> setSec = [];

  freNumToStr() {
    freNum = frequencyNum.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedFrequencyNumChanged(int value) {
    Utils.frequencyNumber = int.parse(frequencyNum[value]);
    notifyListeners();
  }

  comSecToStr() {
    comSec = comebackLogoSec.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedComebackLogoNumChanged(int value) {
    Utils.comeBackSecond = int.parse(comebackLogoSec[value]);
    notifyListeners();
  }

  traSecToStr() {
    traSec =
        transitionSec.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedTransitionNumChanged(int value) {
    Utils.transitionSecond = int.parse(transitionSec[value]);
    notifyListeners();
  }

  setSecToStr() {
    setSec = setUpSec.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedNotifyNumChanged(int value) {
    Utils.notifySecond = int.parse(setUpSec[value]);
    notifyListeners();
  }

  Future getSplashLogoImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.splashLogoImageFile = File(pickedFile!.path);
    notifyListeners();
  }

  Future getSplashBackgroundImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.splashBackgroundImageFile = File(pickedFile!.path);
    notifyListeners();
  }

  Future getFakeBackgroundImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.fakeBackgroundImageFile = File(pickedFile!.path);
    notifyListeners();
  }

  // Future<void> saveSplashSettingElement() async {
  //   // prefs = await SharedPreferences.getInstance();
  //
  //   if (Utils.fakeColorFile != null) {
  //     await prefs.setString('fakeColorFilePath', Utils.fakeColorFile!.path);
  //   }
  //   if (Utils.logoImageFile != null) {
  //     await prefs.setString('logoImageFilePath', Utils.logoImageFile!.path);
  //   }
  //
  //   if (Utils.fakeImageFile != null) {
  //     await prefs.setString('fakeImageFilePath', Utils.fakeImageFile!.path);
  //   }
  //
  //   await prefs.setInt("frequencyNumber", Utils.frequencyNumber);
  //
  //   await prefs.setInt("comebackSecond", Utils.comebackSecond);
  //
  //   await prefs.setInt("transitionSecond", Utils.transitionSecond);
  //
  //   await prefs.setInt("notifySecond", Utils.notifySecond);
  //
  //   // await prefs.setBool('isCanVolumeSwitch', Utils.isCanVolumeSwitch);
  // }

// void changeToggle(bool value) {
//   Utils.isCanVolumeSwitch = value;
//   notifyListeners();
// }
}
