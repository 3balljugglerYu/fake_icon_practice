import 'package:fake_icon_practice/fake/fake_page.dart';
import 'package:fake_icon_practice/performance/performance_model.dart';
import 'package:fake_icon_practice/setting_top/setting_top_page.dart';
import 'package:fake_icon_practice/shared_preference_method.dart';
import 'package:fake_icon_practice/splash/splash_model.dart';
import 'package:fake_icon_practice/splash/splash_page.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/position_model.dart';
import 'package:fake_icon_practice/notchDisplay.dart';
import 'package:fake_icon_practice/tutorial_icon.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../reusable_move_icon.dart';

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
                          Text(''),
                          onPressed: () async {
                            await model.onPressed();
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation){
                                      return ChangeNotifierProvider<SplashModel>(
                                          create: (context) => SplashModel(),
                                        child: SplashPage(),
                                      );
                                    },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                                      final double begin = 0.0;
                                      final double end = 1.0;
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
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => FakePage()));
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
                            await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingTopPage()));
                            model.notifyListeners();
                          },
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
              child: const Padding(
                padding: EdgeInsets.all(100.0),
                child: Text("Tutorial   1 / 5",
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
              y: Utils.splashPosition.y + 50,
              icon: FontAwesomeIcons.handPointer,
              iconSize: 80,
              contColor: Colors.black12.withOpacity(0),
              iconColor: Colors.red,
            ),
            Positioned(
              left: Utils.splashPosition.x,
              top: Utils.splashPosition.y + 135,
              child: const Text(
                "Tap!!",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
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
      } else if (Utils.tutorialCount == 1) {
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
              y: Utils.splashPosition.y + 50,
              icon: FontAwesomeIcons.handPointer,
              iconSize: 80,
              contColor: Colors.black12.withOpacity(0),
              iconColor: Colors.red,
            ),
            Positioned(
              left: Utils.splashPosition.x,
              top: Utils.splashPosition.y + 135,
              child: const Text(
                "Tap Again!!",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
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
                padding: EdgeInsets.all(100.0),
                child: Text("Tutorial   5 / 5\n　Nice!👏👏",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Delicious_Handrawn',
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Padding(
                padding: EdgeInsets.all(100.0),
                child: Text("",
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
              child: const Text(
                "Next Setting Tutorial",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Delicious_Handrawn'
                ),
              ),
            ),
            Positioned(
              left: Utils.settingPosition.x,
              top: Utils.settingPosition.y + 135,
              child: const Text(
                "Tap!!",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Delicious_Handrawn'
                ),
              ),
            ),
          ],
        );
      }
  }
}

