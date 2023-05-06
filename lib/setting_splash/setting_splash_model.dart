import 'dart:io';
import 'package:fake_icon/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/scheduler.dart';

class SettingSplashModel extends ChangeNotifier {
  final frequencyNum = List.generate(11, (index) => "$index");
  final comebackLogoSec = List.generate(61, (index) => "$index");
  final transitionSec = List.generate(61, (index) => "$index");
  final setUpSec = List.generate(11, (index) => "$index");

  List<Center> freNum = [];
  List<Center> comSec = [];
  List<Center> traSec = [];
  List<Center> setSec = [];

  bool isLightMode() {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    return brightness == Brightness.light;
  }

  void switchOnChanged(bool? value){
    if(value != null){
      Utils.addNotch = value;
      if (Utils.addNotch) {
        FlutterStatusbarcolor.setStatusBarColor(Colors.black); // 黒色
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false); // ステータスバーのアイコンを白に
      } else {
          if (isLightMode()) {
            FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          } else {
            FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
            FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          }
      }
      notifyListeners();
    }
  }



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

  bool tutorialSplashImageCreate = false;
  void tutorialSplashCreate(){
    tutorialSplashImageCreate = !tutorialSplashImageCreate;
    notifyListeners();
  }
}
