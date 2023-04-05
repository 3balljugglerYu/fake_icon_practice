import 'package:fake_icon_practice/notchDisplay.dart';
import 'package:fake_icon_practice/position_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/splash/splash_model.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:fake_icon_practice/tutorial_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const iconAnimation = Curves.easeOutCubic;
  @override
  Widget build(BuildContext context) {
    final Size displaySize = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<SplashModel>(
        builder: (BuildContext context, model, Widget? child,){
          model.measureDisplaySize(displaySize);

          if(!model.isSetUpFinish) {
            Future.delayed(const Duration(seconds: 1));
            model.setUp().then((value){
              if (Utils.setUpNumber < Utils.frequencyNumber) {
                Utils.setUpNumber++;
                model.transitionScreen(context);
              } else {
                Utils.setUpNumber = 0;
              }
            });
          }

          return Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: Utils.backgroundImageFile == null
                        ? const DecorationImage(image: AssetImage("images/top_default_image.png"), fit: BoxFit.fill,)
                        : DecorationImage(image: FileImage(Utils.backgroundImageFile!,), fit: BoxFit.fill),
                  ),
              ),
              // AnimatedContainer( //splash_screenの動き
              //   onEnd: (){
              //     model.isAnimationFinish = true;
              //     model.notifyListeners();
              //   },
              //   curve: iconAnimation,
              //   duration: const Duration(milliseconds: 500),
              //   padding: EdgeInsets.only( //isSetUpFinishがtrueになったとき、paddingが0になる。
              //     top: !model.isSetUpFinish ? Utils.splashPosition.y : 0,
              //     left: !model.isSetUpFinish ? Utils.splashPosition.x : 0,
              //     right: !model.isSetUpFinish ? model.displaySize.width - Utils.splashPosition.x - 60 : 0,
              //     bottom: !model.isSetUpFinish ? model.displaySize.height - Utils.splashPosition.y - 60 : 0,
              //   ),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFD8DFFF),
              //       borderRadius: BorderRadius.circular(15),
              //       image: Utils.splashBackgroundImageFile == null
              //           ? null
              //           : DecorationImage(image: FileImage(Utils.splashBackgroundImageFile!,), fit: BoxFit.fill),
              //     ),
              //   ),
              // ),
              AnimatedContainer(//splash_screenの動き
                onEnd: (){
                  model.isAnimationFinish = true;
                  model.notifyListeners();
                },
                curve: iconAnimation,
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.only( //isSetUpFinishがtrueになったとき、paddingが0になる。
                  top: !model.isSetUpFinish ? Utils.splashPosition.y : 0,
                  left: !model.isSetUpFinish ? Utils.splashPosition.x : 0,
                  right: !model.isSetUpFinish ? model.displaySize.width - Utils.splashPosition.x - 60 : 0,
                  bottom: !model.isSetUpFinish ? model.displaySize.height - Utils.splashPosition.y - 60 : 0,
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8DFFF),
                      borderRadius: BorderRadius.circular(15),
                      image: Utils.splashBackgroundImageFile == null
                          ? null
                          : DecorationImage(image: FileImage(Utils.splashBackgroundImageFile!,), fit: BoxFit.fill),
                    ),
                    child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: AnimatedOpacity(
                            curve: iconAnimation,
                            duration: Duration(milliseconds: 500),
                            opacity: !model.isSetUpFinish ? 0.9 : 1,
                            child: AnimatedSize(
                                curve: iconAnimation,
                                duration: Duration(milliseconds: 500),
                              child: AnimatedContainer(
                                curve: iconAnimation,
                                duration: Duration(milliseconds: 500),
                                height: !model.isSetUpFinish ? 80 : model.logoSize.height,
                                width: !model.isSetUpFinish ? 80 : model.logoSize.width,
                                child: Utils.splashLogoImageFile == null
                                    ? Image.asset("images/logo-dove.png", fit:  BoxFit.fill,)
                                    : Image.file(Utils.splashLogoImageFile!, fit: BoxFit.fill,),
                              ),
                            ),
                          ),
                        ),
                    )
                ),
              ),
              //起動アニメーションが終了。ロゴは戻ってきていない。
              if (model.isAnimationFinish && !model.isComeBackLogo)
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8DFFF),
                    borderRadius: BorderRadius.circular(15),
                    image: Utils.splashBackgroundImageFile == null
                        ? null
                        : DecorationImage(image: FileImage(Utils.splashBackgroundImageFile!,), fit: BoxFit.fill),
                  ),
                ),
              //起動アニメーションが終了。ロゴは存在している。ロゴは戻ってきていない。
              if (model.isAnimationFinish &&
                  model.isLogoVisibility &&
                  !model.isComeBackLogo)
              //ロゴを動かすアニメーション
              Positioned(
                left: model.logoPosition.x,
                top: model.logoPosition.y,
                child: Draggable(
                  onDragEnd: (details) async {
                    await model.changeLogoPosition(details, context);
                    if (model.isLogoVisibility == false) {
                      // ignore: use_build_context_synchronously
                      await model.comeBackLogo(context);
                      await Future.delayed(
                        Duration(seconds: Utils.transitionSecond - Utils.notifySecond),
                      ).then((value) => HapticFeedback.heavyImpact());
                      await Future.delayed(
                        Duration(seconds: Utils.notifySecond)
                      );
                      // ignore: use_build_context_synchronously
                      model.transitionScreen(context);
                    }
                  },
                  childWhenDragging: Container(), //ドラッグしている時のドラッグ前のwidgetの見え方
                  feedback: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: Utils.splashLogoImageFile == null
                          ? const DecorationImage(image: AssetImage("images/logo-dove.png"), fit: BoxFit.fill,)
                          : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                    ),
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: Utils.splashLogoImageFile == null
                          ? const DecorationImage(image: AssetImage("images/logo-dove.png"), fit: BoxFit.fill,)
                          : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                    ),
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                  ),
                ),
              ),
              Utils.splashLogoImageFile != null ? Container(color: Colors.white.withOpacity(0),) : const TutorialSplash(),
              Utils.addNotch ? const NotchDisplay() : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}

class TutorialSplash extends StatelessWidget {
  const TutorialSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Utils.setUpNumber < Utils.frequencyNumber) {
      return Stack(
        children: [Container()],
      );
    } else {
      return Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: const Padding(
              padding: EdgeInsets.all(100.0),
              child: Text("Tutorial   3 / 5",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Delicious_Handrawn',
                ),
              ),
            ),
          ),
          TutorialIcon(
            x: Utils.splashPosition.x,
            y: Utils.splashPosition.y + 100,
            icon: FontAwesomeIcons.arrowRightLong,
            iconSize: 80,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.red,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x,
            y: Utils.splashPosition.y + 150,
            icon: FontAwesomeIcons.handPointer,
            iconSize: 80,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.red,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x,
            y: Utils.splashPosition.y + 270,
            icon: FontAwesomeIcons.mobileScreen,
            iconSize: 50,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.blue,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x+20,
            y: Utils.splashPosition.y + 270,
            icon: FontAwesomeIcons.arrowRightLong,
            iconSize: 50,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.blue,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x+70,
            y: Utils.splashPosition.y + 270,
            icon: FontAwesomeIcons.dove,
            iconSize: 30,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.blue,
          ),
          Positioned(
            left: Utils.splashPosition.x,
            top: Utils.splashPosition.y + 350,
            child: Utils.backgroundImageFile == null ? const Text(
              "Drag!!",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Delicious_Handrawn'
              ),
            ) : const Text(""),
          ),
        ],
      );
    }
  }
}
