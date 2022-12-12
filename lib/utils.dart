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

  static int frequencyNumber = 1;
  static int comeBackSecond = 1;
  static int transitionSecond = 5;
  static int notifySecond = 0;
  static int setUpNumber = 0;
}