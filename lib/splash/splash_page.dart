import 'package:fake_icon/notchDisplay.dart';
import 'package:fake_icon/position_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon/splash/splash_model.dart';
import 'package:fake_icon/utils.dart';
import 'package:fake_icon/tutorial_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared_preference_method.dart';

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
                        ? const DecorationImage(image: AssetImage("images/tutorial-default-bg.png"), fit: BoxFit.fill,)
                        : DecorationImage(image: FileImage(Utils.backgroundImageFile!,), fit: BoxFit.fill),
                  ),
              ),
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
                                height: !model.isSetUpFinish ? 80.h : model.logoSize.height,
                                width: !model.isSetUpFinish ? 80.w : model.logoSize.width,
                                child: Utils.splashLogoImageFile == null
                                    ? Image.asset("images/tutorial-splash-logo.png", fit:  BoxFit.fill,)
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
              Utils.splashLogoImageFile != null ? Container(color: Colors.white.withOpacity(0),) : const TutorialSplash(),
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
                      ).then((value) => HapticFeedback.mediumImpact());
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
                          ? const DecorationImage(image: AssetImage("images/tutorial-splash-logo.png"), fit: BoxFit.fill,)
                          : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                    ),
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: Utils.splashLogoImageFile == null
                          ? const DecorationImage(image: AssetImage("images/tutorial-splash-logo.png"), fit: BoxFit.fill,)
                          : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                    ),
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                  ),
                ),
              ),
              Utils.addNotch ? const NotchDisplay() : const SizedBox(),
              Center(
                child: AnimatedOpacity(
                  opacity: model.showDialog ? 1.0 : 0,
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.easeOutCirc,
                  child: Visibility(
                    visible: model.showDialog,
                    child: Visibility(
                      visible: Utils.isSplashPagePopupVisible,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          icon: const Icon(FontAwesomeIcons.splotch),
                          iconColor: Colors.green,
                          backgroundColor: Colors.amberAccent,
                          title: const Text('スプラッシュスクリーンで\n止まりました!!'),
                          content: const Text('アプリ起動時に一瞬ロゴが表示される画面のことをスプラッシュスクリーンと言います。\nロゴをドラッグで動かすことができるので、動かしてみましょう！'),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                model.hidePopup();
                                await SharedPreferenceMethod.saveIsSplashPagePopupVisible();
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                              child: const Text('閉じる',style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
            child: Padding(
              padding: EdgeInsets.only(top: 80.0.sp,left: 10.0.sp,right: 10.0.sp),
              child: Utils.backgroundImageFile == null ? Text("チュートリアル 4/5",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Noto_Sans_JP',
                ),
              ) : const Text(""),
            ),
          ),
          TutorialIcon(
            x: Utils.splashPosition.x.w,
            y: Utils.splashPosition.y + 100.h,
            icon: FontAwesomeIcons.arrowRightLong,
            iconSize: 80.h,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.green,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x.w,
            y: Utils.splashPosition.y + 150.h,
            icon: FontAwesomeIcons.handPointer,
            iconSize: 80.h,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.green,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x.w,
            y: Utils.splashPosition.y + 270.h,
            icon: FontAwesomeIcons.mobileScreen,
            iconSize: 50.h,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.blue,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x+20.w,
            y: Utils.splashPosition.y + 270.h,
            icon: FontAwesomeIcons.arrowRightLong,
            iconSize: 50.h,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.blue,
          ),
          TutorialIcon(
            x: Utils.splashPosition.x+70.w,
            y: Utils.splashPosition.y + 270.h,
            icon: FontAwesomeIcons.dove,
            iconSize: 30.h,
            contColor: Colors.black12.withOpacity(0),
            iconColor: Colors.blue,
          ),
          Positioned(
            left: Utils.splashPosition.x-60.w,
            top: Utils.splashPosition.y + 350.h,
            child: Utils.backgroundImageFile == null
                ? Column(
                    children: [
                       Text(
                        "アイコンを",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Delicious_Handrawn'
                        ),
                      ),
                       Text(
                        "画面の外へドラッグ！",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Delicious_Handrawn'
                        ),
                      ),
                    ],
                ) : const Text(""),
          ),
        ],
      );
    }
  }
}
