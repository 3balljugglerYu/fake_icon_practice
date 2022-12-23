import 'dart:io';
import 'position_model.dart';

class Utils{
  static File? backgroundImageFile;
  static File? fakeImageFile;
  static File? logoImageFile;
  static File? fakeColorFile;

  static Position settingPosition = Position(x: 0, y:0);
  static Position splashPosition = Position(x: 0, y: 0);
  static Position completeButton = Position(x: 120, y: 150);

  //改め回数
  static int frequencyNumber = 1;
  //ロゴ消失後の復帰時間
  static int comeBackSecond = 1;
  //復帰後からの遷移時間
  static int transitionSecond = 5;
  //お知らせタイマー
  static int notifySecond = 0;
  static int setUpNumber = 0;
}