import 'package:fake_icon/performance/performance_model.dart';
import 'package:fake_icon/setting_top/setting_top_page.dart';
import 'package:fake_icon/shared_preference_method.dart';
import 'package:fake_icon/splash/splash_model.dart';
import 'package:fake_icon/splash/splash_page.dart';
import 'package:fake_icon/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon/position_model.dart';
import 'package:fake_icon/notchDisplay.dart';
import 'package:fake_icon/tutorial_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if(!Position.isChange) Position.defaultPosition(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => PerformanceModel(),
        child: Consumer<PerformanceModel>(
          builder: (BuildContext context, model, Widget? child) {
            return FutureBuilder(
              future: SharedPreferenceMethod.getSharedPreferenceData(),
              builder: (context, snapshot){
              return Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Utils.backgroundImageFile == null
                        ? Container(color: Colors.white,)
                        : Image.file(Utils.backgroundImageFile!, fit: BoxFit.fill,),
                  ),
                  Utils.addNotch ? const NotchDisplay() : const SizedBox(),
                  Utils.backgroundImageFile != null ? Container() : const TutorialScreen(),
                  Positioned(
                    left: Utils.splashPosition.x,
                    top: Utils.splashPosition.y,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 60,
                      height: 60,
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.yellow.withOpacity(0),
                        ),
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          child:
                          const Text(''),
                          onPressed: () async {
                            await model.onPressed();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation){
                                      return ChangeNotifierProvider<SplashModel>(
                                          create: (context) => SplashModel(),
                                        child: const SplashPage(),
                                      );
                                    },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                                      const double begin = 0.0;
                                      const double end = 1.0;
                                      final Animatable<double> tween =
                                          Tween(begin: begin, end: end).chain(
                                            CurveTween(
                                                curve: Curves.easeInOut)
                                          );
                                      final Animation<double> doubleAnimation = animation.drive(tween);
                                      return FadeTransition(
                                        opacity: doubleAnimation,
                                        child: child,
                                      );
                                  },
                                ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: Utils.settingPosition.x,
                    top: Utils.settingPosition.y,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red.withOpacity(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                          child: const Text(''),
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingTopPage()));
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                            model.notifyListeners();
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedOpacity(
                      opacity: model.showDialog ? 1.0 : 0,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCirc,
                      child: Visibility(
                        visible: model.showDialog,
                        child: Visibility(
                          visible: Utils.isPerformancePagePopupVisible,
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
                              title: const Text('Thank you!!'),
                              content: const Text('『FakeIcon』をインストールして頂き、ありがとうございます!\nまずは、チュートリアルに沿って操作してみてくださいね！'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    model.hidePopup();
                                    await SharedPreferenceMethod.saveIsPerformancePagePopupVisible();
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
            );
          },
          ),
        ),
    );
  }
}

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      if (Utils.tutorialCount == 0) {
        return Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0,left: 10.0,right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.kiwiBird,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(width: 10,),
                    Text("チュートリアル 1/5",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto_Sans_JP',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y + 50,
              icon: FontAwesomeIcons.handPointer,
              iconSize: 80,
              contColor: Colors.black12.withOpacity(0),
              iconColor: Colors.green,
            ),
            Positioned(
              left: Utils.splashPosition.x - 20,
              top: Utils.splashPosition.y + 135,
              child: const Text(
                "タップ！",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Noto_Sans_JP'
                ),
              ),
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y - 200,
              icon: Icons.camera_alt,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y - 200,
              icon: Icons.calendar_month,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y - 200,
              icon: Icons.collections_outlined,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y - 100,
              icon: Icons.mail,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y - 100,
              icon: Icons.map_outlined,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y - 100,
              icon: Icons.live_tv,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y,
              icon: Icons.library_music,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y,
              icon: FontAwesomeIcons.dove,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y,
              icon: Icons.menu_book,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
          ],
        );
      } else if (Utils.tutorialCount == 1) {
        return Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: const Padding(
                padding: EdgeInsets.only(top: 80.0,left: 10.0,right: 10.0),
                child: Text("チュートリアル 3/5",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto_Sans_JP',
                  ),
                ),
              ),
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y + 50,
              icon: FontAwesomeIcons.handPointer,
              iconSize: 80,
              contColor: Colors.black12.withOpacity(0),
              iconColor: Colors.green,
            ),
            Positioned(
              left: Utils.splashPosition.x-100,
              top: Utils.splashPosition.y + 135,
              child: const Text(
                "もう一度タップして！",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Delicious_Handrawn'
                ),
              ),
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y - 200,
              icon: Icons.camera_alt,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y - 200,
              icon: Icons.calendar_month,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y - 200,
              icon: Icons.collections_outlined,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y - 100,
              icon: Icons.mail,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y - 100,
              icon: Icons.map_outlined,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y - 100,
              icon: Icons.live_tv,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y,
              icon: Icons.library_music,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y,
              icon: FontAwesomeIcons.dove,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y,
              icon: Icons.menu_book,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
          ],
        );
      } else {
        return Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: const Padding(
                padding: EdgeInsets.only(top: 80.0,left: 10.0,right: 10.0),
                child: Text("チュートリアル 5/5 🎉",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto_Sans_JP',
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Padding(
                padding: EdgeInsets.only(top: 130.0,left: 10.0,right: 10.0),
                child: Text("お疲れ様でした！",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto_Sans_JP',
                  ),
                ),
              ),
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y - 200,
              icon: Icons.camera_alt,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y - 200,
              icon: Icons.calendar_month,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y - 200,
              icon: Icons.collections_outlined,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y - 100,
              icon: Icons.mail,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y - 100,
              icon: Icons.map_outlined,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y - 100,
              icon: Icons.live_tv,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x - 100,
              y: Utils.splashPosition.y,
              icon: Icons.library_music,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x,
              y: Utils.splashPosition.y,
              icon: FontAwesomeIcons.dove,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.splashPosition.x + 100,
              y: Utils.splashPosition.y,
              icon: Icons.menu_book,
              iconSize: 40,
              contColor: Colors.black12.withOpacity(0.1),
              iconColor: Colors.white,
            ),
            TutorialIcon(
              x: Utils.settingPosition.x,
              y: Utils.settingPosition.y,
              icon: Icons.settings,
              iconSize: 40,
              contColor: Colors.black12,
              iconColor: Colors.black54,
            ),
            TutorialIcon(
              x: Utils.settingPosition.x,
              y: Utils.settingPosition.y + 50,
              icon: FontAwesomeIcons.handPointer,
              iconSize: 80,
              contColor: Colors.black12.withOpacity(0),
              iconColor: Colors.blue,
            ),
            Positioned(
              left: Utils.settingPosition.x / 3,
              top: Utils.settingPosition.y - 100,
              child: Container(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top:10.0, left: 10.0,right: 10.0),
                  child: Text("最後に、設定を見ていきましょう！",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto_Sans_JP',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: Utils.settingPosition.x-50,
              top: Utils.settingPosition.y + 135,
              child: Container(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top:10.0, left: 10.0,right: 10.0),
                  child: Text("タップして下さい！",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto_Sans_JP',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
  }
}

