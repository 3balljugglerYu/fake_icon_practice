import 'dart:io';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingSplashModel extends ChangeNotifier {
  final frequencyNum = List.generate(11, (index) => "$index");
  final comebackLogoSec = List.generate(61, (index) => "$index");
  final transitionSec = List.generate(61, (index) => "$index");
  final setUpSec = List.generate(11, (index) => "$index");

  List<Center> freNum = [];
  List<Center> comSec = [];
  List<Center> traSec = [];
  List<Center> setSec = [];

  switchOnChanged(bool? value){
    if(value != null){
      Utils.addNotch = value;
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
}
