import 'package:fake_icon_practice/position_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/splash/splash_model.dart';
import 'package:fake_icon_practice/utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final Size displaySize = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<SplashModel>(
        builder: (
        BuildContext context,
            model,
            Widget? child,
        ){
          model.measureDisplaySize(displaySize);

          if(model.isSetUpFinish){
            model.setUp();
            if (Utils.setUpNumber < Utils.frequencyNumber) {
              Utils.setUpNumber++;
              model.transitionScreen(context);
            } else {
              Utils.setUpNumber = 0;
            }
          }

          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset('images/line-background.png'),
              ),
              if(model.isLogoVisibility)
              Positioned(
                left: model.logoPosition.x,
                top: model.logoPosition.y,
                child: Draggable(
                  onDragEnd: (details) {
                    model.changeLogoPosition(details);
                      if (model.isLogoVisibility == false) {
                         model.comeBackLogo();
                         model.transitionScreen(context);
                      }
                  },
                  childWhenDragging: Container(), //ドラッグしている時のドラッグ前のwidgetの見え方
                  feedback: SizedBox( //ドラッグしている時の見え方
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                    child: Image.asset('images/line-logo.png'),
                  ),
                  child: SizedBox(
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                    child: Image.asset('images/line-logo.png'),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}


// class SplashPage extends StatelessWidget {
//   const SplashPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Size display = MediaQuery.of(context).size;
//     Duration animationMilliseconds = const Duration(milliseconds: 300);
//
//     return Scaffold(
//       body: Consumer<SplashModel>(
//         builder: (BuildContext context, model, Widget? child) {
//           model.measureDisplaySize(display);
//           if (!model.isSetUpFinish) {
//             model.setUp().then(
//                   (value) {
//                 if (Utils.setUpNumber < Utils.frequencyNumber) {
//                   Utils.setUpNumber++;
//                   model.transitionScreen(context);
//                 } else {
//                   Utils.setUpNumber = 0;
//                 }
//               },
//             );
//           }
//           return Stack(
//             children: [
//               buildBackgroundImage(),
//               buildAnimatedContainer(model, animationMilliseconds),
//               //以下logoを移動させるWidget
//               if (model.isAnimationFinish && !model.isComeBackLogo)
//                 buildSplashBackImage(),
//               if (model.isAnimationFinish &&
//                   model.isLogoVisibility &&
//                   !model.isComeBackLogo)
//                 Positioned(
//                   left: model.logoPosition.x,
//                   top: model.logoPosition.y,
//                   child: Draggable(
//                     onDragEnd: (details) async {
//                       await model.changeLogoPosition(details, context);
//                       if (model.isLogoVisibility == false) {
//                         await model.comeBackLogo(context);
//                         await Future.delayed(Duration(
//                             seconds: Utils.transitionSecond -
//                                 Utils.notifySecond))
//                             .then((value) {
//                           HapticFeedback.heavyImpact();
//                         });
//                         await Future.delayed(
//                             Duration(seconds: Utils.notifySecond));
//                         model.transitionScreen(context);
//                       }
//                     },
//                     childWhenDragging: Container(),
//                     feedback: Container(
//                       height: model.logoSize.height,
//                       width: model.logoSize.width,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Utils.logoImageFile != null
//                             ? Image.file(
//                           Utils.logoImageFile!,
//                           fit: BoxFit.fill,
//                         )
//                             : Image.asset(
//                           'images/line-logo.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     child: Container(
//                       height: model.logoSize.height,
//                       width: model.logoSize.width,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Utils.logoImageFile != null
//                             ? Image.file(
//                           Utils.logoImageFile!,
//                           fit: BoxFit.fill,
//                         )
//                             : Image.asset(
//                           'images/line-logo.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//
//   Container buildSplashBackImage(){
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       child: Utils.fakeColorFile != null
//           ? Image.file(Utils.fakeColorFile!, fit: BoxFit.fill,)
//           : Image.asset("images/line-background.png",fit: BoxFit.fill,),
//     );
//   }
//
//   AnimatedContainer buildAnimatedContainer(SplashModel model, Duration animationMilliseconds){
//     return AnimatedContainer(
//       onEnd: (){
//         model.isAnimationFinish = true;
//         model.notifyListeners();
//       },
//       padding: EdgeInsets.only(
//         top: !model.isSetUpFinish ? Utils.splashPosition.y : 0,
//         left: !model.isSetUpFinish ? Utils.splashPosition.x : 0,
//         right: !model.isSetUpFinish ? model.displaySize.width - Utils.splashPosition.x - 80 : 0,
//         bottom: !model.isSetUpFinish ? model.displaySize.height - Utils.splashPosition.y - 80 : 0,
//       ),
//       curve: Curves.easeInOutCirc,
//       height: model.displaySize.height,
//       width: model.displaySize.width,
//       duration: animationMilliseconds,
//       child: AnimatedContainer(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           image: Utils.fakeColorFile != null ? DecorationImage(
//               image: FileImage(
//                 Utils.fakeColorFile!,
//               ),
//             fit: BoxFit.fill
//           ) : const DecorationImage(
//               image: AssetImage('images/line-background.png'),
//               fit: BoxFit.fill),
//         ),
//         duration: animationMilliseconds,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Center(
//             child: AnimatedContainer(
//               curve: Curves.easeInOutCirc,
//               duration: animationMilliseconds,
//               height: model.logoSize.height,
//               width: model.logoSize.width,
//               child: Utils.logoImageFile != null
//                   ? Image.file(
//                 Utils.logoImageFile!,
//                 fit: BoxFit.fill,
//               )
//                   : Image.asset(
//                 'images/line-logo.png',
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   SizedBox buildBackgroundImage() {
//     return SizedBox(
//       height: double.infinity,
//       width: double.infinity,
//       child: Utils.backgroundImageFile == null
//           ? Image.asset('images/performance-page.jpg')
//           : Image.file(
//         Utils.backgroundImageFile!,
//         fit: BoxFit.fill,
//       ),
//     );
//   }
// }
