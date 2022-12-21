import 'package:fake_icon_practice/fake/fake_page.dart';
import 'package:flutter/material.dart';
import 'package:fake_icon_practice/position_model.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashModel extends ChangeNotifier {
  Position logoPosition = Position(x: 0, y: 0);
  Size displaySize = const Size(0, 0);
  Size logoSize = const Size(200, 200);
  bool isSetUpFinish = true;
  bool isLogoVisibility = true;

  void measureDisplaySize(Size size) async {
    displaySize = size;
  }

  Future<void> setUp() async {
    logoPosition.x = (displaySize.width - logoSize.width) / 2;
    logoPosition.y = (displaySize.height - logoSize.height) / 2;
    isSetUpFinish = false;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

  void changeLogoPosition(DraggableDetails details) {
    logoPosition.x = details.offset.dx;
    logoPosition.y = details.offset.dy;
    logoVisibility();
    notifyListeners();
  }

  void logoVisibility() {
    if(logoPosition.x > displaySize.width - (logoSize.width / 2) || logoPosition.x < -(logoSize.width / 2)){
      isLogoVisibility = false;
    }
    if(logoPosition.y < -(logoSize.height / 2) || logoPosition.y > displaySize.height - (logoSize.height /2)){
      isLogoVisibility = false;
    }
  }

  Future<void> comeBackLogo() async {
    setUp();
    await Future.delayed(Duration(seconds: Utils.comeBackSecond));
    isLogoVisibility = true;
    notifyListeners();
  }

  Future<void> transitionScreen(BuildContext context) async {
    await Future.delayed(Duration(seconds: Utils.transitionSecond));
    Navigator.push(context, MaterialPageRoute(builder: (context) => FakePage()));
  }

}

// class SplashModel extends ChangeNotifier {
//   Position logoPosition = Position(x: 0, y: 0);
//
//   //isSetUpはアプリ起動の再現が行われたかの判断
//   bool isSetUpFinish = false;
//   bool isAnimationFinish = false;
//   bool isLogoVisibility = true;
//   bool isComeBackLogo = false;
//
//   Size displaySize = const Size(0, 0);
//   Size logoSize = const Size(200, 200);
//
//   Future<void> setUp() async {
//     logoPosition.x = (displaySize.width - logoSize.width) / 2;
//     logoPosition.y = (displaySize.height - logoSize.height) / 2;
//
//     //画面が立ち上がってから、アニメーションが発生するまでの長さ
//     await Future.delayed(const Duration(milliseconds: 100));
//     isSetUpFinish = true;
//
//     notifyListeners();
//
//     //スプラッシュ画面が表示される秒数
//     await Future.delayed(const Duration(seconds: 1));
//   }
//
//   Future<void> changeLogoPosition(
//       DraggableDetails details, BuildContext context) async {
//     logoPosition.x = details.offset.dx;
//     logoPosition.y = details.offset.dy;
//     await logoVisibility(context);
//     notifyListeners();
//   }
//
//   Future<void> logoVisibility(BuildContext context) async {
//     if (logoPosition.x < -(logoSize.width / 3) ||
//         logoPosition.x + logoSize.width - displaySize.width >
//             logoSize.width / 3) {
//       isLogoVisibility = false;
//     }
//     if (logoPosition.y < -(logoSize.height / 3) ||
//         logoPosition.y + logoSize.height - displaySize.height >
//             logoSize.height / 3) {
//       isLogoVisibility = false;
//     }
//   }
//
//   Future<void> comeBackLogo(BuildContext context) async {
//     setUp();
//     await Future.delayed(
//         Duration(seconds: Utils.comeBackSecond - Utils.notifySecond))
//         .then((value) {
//       HapticFeedback.heavyImpact();
//     });
//     await Future.delayed(Duration(seconds: Utils.notifySecond));
//     isComeBackLogo = true;
//     notifyListeners();
//   }
//
//   void transitionScreen(BuildContext context) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return FakePage();
//         },
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const double begin = 0.0;
//           const double end = 1.0;
//           final Animatable<double> tween = Tween(begin: begin, end: end)
//               .chain(CurveTween(curve: Curves.easeInOut));
//           final Animation<double> doubleAnimation = animation.drive(tween);
//           return FadeTransition(
//             opacity: doubleAnimation,
//             child: child,
//           );
//         },
//       ),
//     );
//   }
//
//   void measureDisplaySize(Size size) async {
//     displaySize = size;
//   }
// }