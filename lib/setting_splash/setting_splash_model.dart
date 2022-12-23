import 'dart:io';

import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SettingSplashModel extends ChangeNotifier {
  // late SharedPreferences prefs;

  final frequencyNum = List.generate(11, (index) => "$index");
  final comeSec = List.generate(60, (index) => "${index + 1}");
  final transitionSec = List.generate(60, (index) => "${index + 1}");
  final setUpSec = List.generate(11, (index) => "$index");

  List<Center> freNum = [];
  List<Center> comSec = [];
  List<Center> traSec = [];
  List<Center> setSec = [];

  freNumToStr() {
    freNum = frequencyNum.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedItemChanged(int value) {
    Utils.frequencyNumber = int.parse(frequencyNum[value]);
    notifyListeners();
  }

  comSecToStr() {
    comSec = comeSec.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedItemChanged2(int value) {
    Utils.comeBackSecond = int.parse(comeSec[value]);
    notifyListeners();
  }

  traSecToStr() {
    traSec =
        transitionSec.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedItemChanged3(int value) {
    Utils.transitionSecond = int.parse(transitionSec[value]);
    notifyListeners();
  }

  setSecToStr() {
    setSec = setUpSec.map((number) => Center(child: Text(number))).toList();
  }

  onSelectedItemChanged4(int value) {
    Utils.notifySecond = int.parse(setUpSec[value]);
    notifyListeners();
  }

  Future getLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.logoImageFile = File(pickedFile!.path);
    notifyListeners();
  }

  Future getFakeColor() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.fakeColorFile = File(pickedFile!.path);
    notifyListeners();
  }

  Future getFakeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.fakeImageFile = File(pickedFile!.path);
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
