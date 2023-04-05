import 'dart:io';
import 'position_model.dart';

class Utils{
  static int tutorialCount = 0;
  static File? backgroundImageFile;
  static File? splashLogoImageFile;
  static File? splashBackgroundImageFile;
  static File? fakeBackgroundImageFile;

  static Position settingPosition = Position(x: 0, y:0);
  static Position splashPosition = Position(x: 0, y: 0);
  static Position completeButton = Position(x: 120, y: 150);

  //改めた回数をカウント
  static int setUpNumber = 0;

  //改め回数
  static int frequencyNumber = 1;
  //ロゴ消失後の復帰時間
  static int comeBackSecond = 2;
  //復帰後からの遷移時間
  static int transitionSecond = 2;
  //お知らせタイマー
  static int notifySecond = 1;
  //ノッチの表示非表示
  static bool addNotch = false;
}