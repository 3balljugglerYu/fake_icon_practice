import 'dart:async';

import 'package:fake_icon/fake/fake_page.dart';
import 'package:flutter/material.dart';
import 'package:fake_icon/position_model.dart';
import 'package:fake_icon/utils.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// class SplashModel extends ChangeNotifier {
//   Position logoPosition = Position(x: 0, y: 0);
//   Size displaySize = const Size(0, 0);
//   Size logoSize = const Size(200, 200);
//   bool isSetUpFinish = false;
//   bool isLogoVisibility = true;
//   bool isAnimationFinish = false;
//   //   bool isSetUpFinish = false;
//   //   bool isAnimationFinish = false;
//   //   bool isLogoVisibility = true;
//   //   bool isComeBackLogo = false;
//
//   void measureDisplaySize(Size size) async {
//     displaySize = size;
//   }
//
//   Future<void> setUp() async {
//     logoPosition.x = (displaySize.width - logoSize.width) / 2;
//     logoPosition.y = (displaySize.height - logoSize.height) / 2;
//     isSetUpFinish = true;
//     await Future.delayed(const Duration(seconds: 1));
//     notifyListeners();
//   }
//
//   Future<void> changeLogoPosition(DraggableDetails details) async {
//     logoPosition.x = details.offset.dx;
//     logoPosition.y = details.offset.dy;
//     logoVisibility();
//     notifyListeners();
//   }
//
//   void logoVisibility() {
//     if(logoPosition.x > displaySize.width - (logoSize.width / 2) || logoPosition.x < -(logoSize.width / 2)){
//       isLogoVisibility = false;
//     }
//     if(logoPosition.y < -(logoSize.height / 2) || logoPosition.y > displaySize.height - (logoSize.height /2)){
//       isLogoVisibility = false;
//     }
//   }
//
//   Future<void> comeBackLogo() async {
//     setUp();
//     await Future.delayed(Duration(seconds: Utils.comeBackSecond));
//     isLogoVisibility = true;
//     notifyListeners();
//   }
//
//   void transitionScreen(BuildContext context) async {
//     // await Future.delayed(Duration(seconds: Utils.transitionSecond));
//     Navigator.of(context).push(
//       PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation){
//             return FakePage();
//           },
//         transitionsBuilder: (context, animation, secondaryAnimation, child){
//             const double begin = 0.0;
//             const double end = 1.0;
//             final Animatable<double> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
//             final Animation<double> doubleAnimation = animation.drive(tween);
//             return FadeTransition(
//               opacity: doubleAnimation,
//               child: child,
//             );
//         }
//       )
//     );
//   }
//
//     // Navigator.of(context).push(
//     //   PageRouteBuilder(
//     //     pageBuilder: (context, animation, secondaryAnimation) {
//     //       return FakePage();
//     //     },
//     //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//     //       const double begin = 0.0;
//     //       const double end = 1.0;
//     //       final Animatable<double> tween = Tween(begin: begin, end: end)
//     //           .chain(CurveTween(curve: Curves.easeInOut));
//     //       final Animation<double> doubleAnimation = animation.drive(tween);
//     //       return FadeTransition(
//     //         opacity: doubleAnimation,
//     //         child: child,
//     //       );
//     //     },
//     //   ),
//     // );
//
// }

class SplashModel extends ChangeNotifier {
  Position logoPosition = Position(x: 0, y: 0);

  //isSetUpはアプリ起動の再現が行われたかの判断
  bool isSetUpFinish = false;
  bool isAnimationFinish = false; //true=アニメーション終了
  bool isLogoVisibility = true;
  bool isComeBackLogo = false;  //true=ロゴが戻ってきた

  Size displaySize = const Size(0, 0);
  Size logoSize = const Size(200, 200);

  Future<void> setUp() async {
    logoPosition.x = (displaySize.width - logoSize.width) / 2;
    logoPosition.y = (displaySize.height - logoSize.height) / 2;

    //画面が立ち上がってから、アニメーションが発生するまでの長さ
    await Future.delayed(const Duration(milliseconds: 100));
    isSetUpFinish = true;

    notifyListeners();

    //スプラッシュ画面が表示される秒数
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> changeLogoPosition(
      DraggableDetails details, BuildContext context) async {
    logoPosition.x = details.offset.dx;
    logoPosition.y = details.offset.dy;
    await logoVisibility(context);
    notifyListeners();
  }

  Future<void> logoVisibility(BuildContext context) async {
    if (logoPosition.x < -(logoSize.width / 3) ||
        logoPosition.x + logoSize.width - displaySize.width >
            logoSize.width / 3) {
      isLogoVisibility = false;
    }
    if (logoPosition.y < -(logoSize.height / 3) ||
        logoPosition.y + logoSize.height - displaySize.height >
            logoSize.height / 3) {
      isLogoVisibility = false;
    }
  }

  Future<void> comeBackLogo(BuildContext context) async {
    setUp();
    await Future.delayed(
        Duration(seconds: Utils.comeBackSecond - Utils.notifySecond))
        .then((value) {
      HapticFeedback.heavyImpact();
    });
    await Future.delayed(Duration(seconds: Utils.notifySecond));
    isComeBackLogo = true;
    notifyListeners();
  }

  void transitionScreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FakePage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const double begin = 0.0;
          const double end = 1.0;
          final Animatable<double> tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.easeInOut));
          final Animation<double> doubleAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: doubleAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void measureDisplaySize(Size size) async {
    displaySize = size;
  }

  void hidePopup() {
    Utils.isSplashPagePopupVisible = false;
    showDialog = false;
    notifyListeners();
  }

  late Timer timer;
  bool showDialog = false;

  SplashModel() {
    timer = Timer(const Duration(seconds: 3), showAlertDialog);
  }

  void showAlertDialog() {
    showDialog = true;
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}