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
          Duration animationMilliseconds = const Duration(milliseconds: 300);

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
              SizedBox(
                child: Image.asset("images/performance-page.jpg"),
              ),
              AnimatedContainer(
                onEnd: (){
                  model.isAnimationFinish = true;
                  model.notifyListeners();
                },
                curve: Curves.easeInOutCirc,
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.only(
                  top: !model.isSetUpFinish ? Utils.splashPosition.y : 0,
                  left: !model.isSetUpFinish ? Utils.splashPosition.x : 0,
                  right: !model.isSetUpFinish ? model.displaySize.width - Utils.splashPosition.x - 80 : 0,
                  bottom: !model.isSetUpFinish ? model.displaySize.height - Utils.splashPosition.y - 80 : 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage("images/line-background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: model.logoSize.height,
                      width: model.logoSize.width,
                      child: Image.asset("images/line-logo.png"),
                    ),
                  )
                ),
              ),
              if (model.isAnimationFinish && !model.isComeBackLogo)
                SizedBox(
                  child: Image.asset("images/line-background.png"),
                ),
              if (model.isAnimationFinish &&
                  model.isLogoVisibility &&
                  !model.isComeBackLogo)

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
