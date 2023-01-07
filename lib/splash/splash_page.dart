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
                        ? const DecorationImage(image: AssetImage("images/performance-page.jpg"), fit: BoxFit.fill,)
                        : DecorationImage(image: FileImage(Utils.backgroundImageFile!,), fit: BoxFit.fill),
                  ),
              ),
              AnimatedContainer( //splash_screenの動き
                onEnd: (){
                  model.isAnimationFinish = true;
                  model.notifyListeners();
                },
                curve: Curves.easeInOutQuart,
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.only( //isSetUpFinishがtrueになったとき、paddingが0になる。
                  top: !model.isSetUpFinish ? Utils.splashPosition.y : 0,
                  left: !model.isSetUpFinish ? Utils.splashPosition.x : 0,
                  right: !model.isSetUpFinish ? model.displaySize.width - Utils.splashPosition.x - 60 : 0,
                  bottom: !model.isSetUpFinish ? model.displaySize.height - Utils.splashPosition.y - 60 : 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: Utils.splashBackgroundImageFile == null
                        ? const DecorationImage(image: AssetImage("images/line-background.png"), fit: BoxFit.fill,)
                        : DecorationImage(image: FileImage(Utils.splashBackgroundImageFile!,), fit: BoxFit.fill),
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: Utils.splashLogoImageFile == null
                            ? const DecorationImage(image: AssetImage("images/line-logo.png"), fit: BoxFit.fill,)
                            : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                      ),
                      height: model.logoSize.height,
                      width: model.logoSize.width,
                    ),
                  )
                ),
              ),
              //起動アニメーションが終了。ロゴは戻ってきていない。
              if (model.isAnimationFinish && !model.isComeBackLogo)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: Utils.splashBackgroundImageFile == null
                        ? const DecorationImage(image: AssetImage("images/line-background.png"), fit: BoxFit.fill,)
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
                      await Future.delayed(Duration(seconds: Utils.transitionSecond));
                      // ignore: use_build_context_synchronously
                      model.transitionScreen(context);
                    }
                  },
                  childWhenDragging: Container(), //ドラッグしている時のドラッグ前のwidgetの見え方
                  feedback: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: Utils.splashLogoImageFile == null
                          ? const DecorationImage(image: AssetImage("images/line-logo.png"), fit: BoxFit.fill,)
                          : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                    ),
                    height: model.logoSize.height,
                    width: model.logoSize.width,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: Utils.splashLogoImageFile == null
                          ? const DecorationImage(image: AssetImage("images/line-logo.png"), fit: BoxFit.fill,)
                          : DecorationImage(image: FileImage(Utils.splashLogoImageFile!,), fit: BoxFit.fill),
                    ),
                    height: model.logoSize.height,
                    width: model.logoSize.width,
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
