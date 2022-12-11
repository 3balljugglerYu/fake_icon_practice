import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';

class FakeModel extends ChangeNotifier {
  int imageAnimationDuration = 0;
  Offset startDragPosition = Offset.zero;
  Offset currentDragPosition = Offset.zero;
  int dragCount = 0;
  Size? displaySize;
  double resizedAppSwitcher = 0.7;
  Function? toPerformancePage;
  BorderRadius borderRadius = BorderRadius.circular(0);
  late double appSwitcherPositionX = (displaySize!.width - displaySize!.width * resizedAppSwitcher) / 2;
  late double appSwitcherPositionY = (displaySize!.height - displaySize!.height * resizedAppSwitcher) / 2;

  void onVerticalDragStart(DragStartDetails startDetails){
    if (dragCount == 0){
      imageAnimationDuration = 0;
      startDragPosition = startDetails.globalPosition;
    } else {
      startDragPosition = startDetails.globalPosition;
      currentDragPosition = Offset(appSwitcherPositionX, appSwitcherPositionY);
    }
    notifyListeners();
  }

  void onVerticalDragUpdate(DragUpdateDetails draggingDetails){
    borderRadius = BorderRadius.circular(35);
    if(dragCount == 0) {
      currentDragPosition = Offset(
        draggingDetails.globalPosition.dx - startDragPosition.dx,
        draggingDetails.globalPosition.dy - startDragPosition.dy,
      );
    }else{
      currentDragPosition = Offset(
        appSwitcherPositionX,
        draggingDetails.globalPosition.dy - startDragPosition.dy + appSwitcherPositionY,
      );
    }
    notifyListeners();
  }

  dynamic onVerticalDragEnd(DragEndDetails endDetails){
    double dragDistance = currentDragPosition.distance;
    print(dragDistance);
    if(dragDistance < 20.0) {
      borderRadius = BorderRadius.circular(0);
      imageAnimationDuration = 400;
      currentDragPosition = Offset.zero;
      print(currentDragPosition);
    } else if (dragDistance >= 20.0 && dragCount == 0){
      borderRadius = BorderRadius.circular(35);
      imageAnimationDuration = 350;
      currentDragPosition = Offset(appSwitcherPositionX, appSwitcherPositionY);
      dragCount = 1;
    } else if (dragCount == 1){
      borderRadius = BorderRadius.circular(35);
      imageAnimationDuration = 500;
      currentDragPosition =
          Offset(appSwitcherPositionX, displaySize!.height * -1.1);
      toPerformancePage!();
    }
    notifyListeners();
  }

  dynamic onLongPress(){
    borderRadius = BorderRadius.circular(35);
    imageAnimationDuration = 350;
    currentDragPosition = Offset(appSwitcherPositionX, appSwitcherPositionY);
    dragCount = 1;
    notifyListeners();
  }

  Matrix4 get imageTransform {
    if ( dragCount == 0){
      final translationTransform = Matrix4.translationValues(
        currentDragPosition.dx,
        currentDragPosition.dy,
        0.0,
      );

      final scaleTransform = Matrix4.diagonal3Values(
          imageScale,
          imageScale,
          1.0,
      );
      return translationTransform * scaleTransform;
    } else {
      final translationTransform = Matrix4.translationValues(
        currentDragPosition.dx,
        currentDragPosition.dy,
        0.0,
      );
      final scaleTransform = Matrix4.diagonal3Values(
        resizedAppSwitcher,
        resizedAppSwitcher,
        1.0,
      );
      return translationTransform * scaleTransform;
    }
  }

  double get imageScale {
    return max(
      1.0 - currentDragPosition.distance * 0.002,
      0.6,
    );
  }
}
