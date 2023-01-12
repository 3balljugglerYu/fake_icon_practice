import 'dart:io';
import 'package:fake_icon_practice/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceMethod{
  static late SharedPreferences prefs;

  static Future getSharedPreferenceData() async {
    prefs = await SharedPreferences.getInstance();

    final backgroundImageFilePath = prefs.getString('backgroundImageFilePath');
    if(backgroundImageFilePath != null ){
      Utils.backgroundImageFile = File(backgroundImageFilePath);
    }

    final splashLogoImageFilePath = prefs.getString('splashLogoImageFilePath');
    if(splashLogoImageFilePath != null){
      Utils.splashLogoImageFile = File(splashLogoImageFilePath);
    }

  }

  static Future<void> saveBackgroundImageFile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Utils.backgroundImageFile != null){
      prefs.setString('backgroundImageFilePath', Utils.backgroundImageFile!.path);
    }
  }

  static Future<void> saveSplashLogoImageFile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Utils.splashLogoImageFile != null){
      prefs.setString('splashLogoImageFilePath', Utils.splashLogoImageFile!.path);
    }
  }
}