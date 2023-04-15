import 'dart:io';
import 'package:fake_icon_practice/position_model.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceMethod {
  static late SharedPreferences prefs;

  static Future getSharedPreferenceData() async {
    prefs = await SharedPreferences.getInstance();

    final backgroundImageFilePath = prefs.getString('backgroundImageFilePath');
    if (backgroundImageFilePath != null) {
      Utils.backgroundImageFile = File(backgroundImageFilePath);
    }

    final splashLogoImageFilePath = prefs.getString('splashLogoImageFilePath');
    if (splashLogoImageFilePath != null) {
      Utils.splashLogoImageFile = File(splashLogoImageFilePath);
    }

    final splashBackgroundImageFilePath = prefs.getString(
        'splashBackgroundImageFilePath');
    if (splashBackgroundImageFilePath != null) {
      Utils.splashBackgroundImageFile = File(splashBackgroundImageFilePath);
    }

    final fakeBackgroundImageFilePath = prefs.getString(
        'fakeBackgroundImageFilePath');
    if (fakeBackgroundImageFilePath != null) {
      Utils.fakeBackgroundImageFile = File(fakeBackgroundImageFilePath);
    }

    Utils.frequencyNumber = prefs.getInt('frequencyNumber') ?? 1;
    Utils.comeBackSecond = prefs.getInt('comeBackSecond') ?? 2;
    Utils.transitionSecond = prefs.getInt('transitionSecond') ?? 2;
    Utils.notifySecond = prefs.getInt('notifySecond') ?? 1;

    final splashIconPositionX = prefs.getDouble('splashIconPositionX');
    final splashIconPositionY = prefs.getDouble('splashIconPositionY');
    if (prefs.getDouble('splashIconPositionX') != null) {
      Utils.splashPosition = Position(
          x: splashIconPositionX!,
          y: splashIconPositionY!
      );
    }

    final settingIconPositionX = prefs.getDouble('settingIconPositionX');
    final settingIconPositionY = prefs.getDouble('settingIconPositionY');
    if (prefs.getDouble('settingIconPositionX') != null) {
      Utils.settingPosition = Position(
          x: settingIconPositionX!,
          y: settingIconPositionY!
      );
    }

    Utils.addNotch = prefs.getBool('addNotchBool') ?? true;
    Utils.isPerformancePagePopupVisible =
        prefs.getBool('isPerformancePagePopupVisible') ?? true;
    Utils.isFakePagePopupVisible =
        prefs.getBool('isFakePagePopupVisible') ?? true;
    Utils.isSplashPagePopupVisible =
        prefs.getBool('isSplashPagePopupVisible') ?? true;
  }

  static Future<void> saveBackgroundImageFile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Utils.backgroundImageFile != null) {
      prefs.setString(
          'backgroundImageFilePath', Utils.backgroundImageFile!.path);
    }
  }

  static Future<void> saveSplashSettingElement() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (Utils.splashLogoImageFile != null) {
      await prefs.setString(
          'splashLogoImageFilePath', Utils.splashLogoImageFile!.path);
    }

    if (Utils.splashBackgroundImageFile != null) {
      await prefs.setString('splashBackgroundImageFilePath',
          Utils.splashBackgroundImageFile!.path);
    }

    if (Utils.fakeBackgroundImageFile != null) {
      await prefs.setString(
          'fakeBackgroundImageFilePath', Utils.fakeBackgroundImageFile!.path);
    }
    await prefs.setInt('frequencyNumber', Utils.frequencyNumber);
    await prefs.setInt('comeBackSecond', Utils.comeBackSecond);
    await prefs.setInt('transitionSecond', Utils.transitionSecond);
    await prefs.setInt('notifySecond', Utils.notifySecond);
    await prefs.setBool('addNotchBool', Utils.addNotch);
  }

  static Future<void> saveSettingIconPosition() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('splashIconPositionX', Utils.splashPosition.x);
    await prefs.setDouble('splashIconPositionY', Utils.splashPosition.y);
    await prefs.setDouble('settingIconPositionX', Utils.settingPosition.x);
    await prefs.setDouble('settingIconPositionY', Utils.settingPosition.y);
  }

  static Future<void> saveIsPerformancePagePopupVisible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isPerformancePagePopupVisible', Utils.isPerformancePagePopupVisible);
  }

  static Future<void> saveIsFakePagePopupVisible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFakePagePopupVisible', Utils.isFakePagePopupVisible);
  }

  static Future<void> saveIsSplashPagePopupVisible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSplashPagePopupVisible', Utils.isSplashPagePopupVisible);
  }
}