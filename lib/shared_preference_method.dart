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
  }

  static Future<void> saveBackgroundImageFile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Utils.backgroundImageFile != null){
      prefs.setString('backgroundImageFilePath', Utils.backgroundImageFile!.path);
    }
  }
}