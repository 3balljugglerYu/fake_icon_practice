import 'package:fake_icon_practice/fake/fake_page.dart';
import 'package:fake_icon_practice/performance/performance_model.dart';
import 'package:fake_icon_practice/setting_top/setting_top_page.dart';
import 'package:fake_icon_practice/splash/splash_model.dart';
import 'package:fake_icon_practice/splash/splash_page.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/position_model.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!Position.isChange) Position.defaultPosition(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => PerformanceModel(),
        child: Consumer<PerformanceModel>(
          builder: (BuildContext context, model, Widget? child) {
            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Utils.backgroundImageFile == null
                      ? Image.asset('images/performance-page.jpg', fit: BoxFit.fill,)
                      : Image.file(Utils.backgroundImageFile!, fit: BoxFit.fill,),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).padding.top * 1.1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: CustomPaint(
                            painter: RightPainter(),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: CustomPaint(
                            painter: LeftPainter(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
                        color: Colors.yellow.withOpacity(0.8),
                      ),
                      duration: const Duration(milliseconds: 200),
                      child: TextButton(
                        child:
                        Text('splash'),
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
                      color: Colors.red.withOpacity(0.8),
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
                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: Colors.red,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10)
                        //   ),
                        // ),
                        child: const Text('Button'),
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
          ),
        ),
    );
  }
}

class RightPain extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 120;
    canvas.drawArc(
        const Rect.fromLTRB(-60, -60, 80, 80),
        3.14, //radians
        1.6, //radians
        false,
        paint1);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class RightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 120;
    canvas.drawArc(
        const Rect.fromLTRB(-60, -60, 80, 80),
        3.14, //radians
        1.6, //radians
        false,
        paint1);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LeftPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 120;
    canvas.drawArc(
        const Rect.fromLTRB(20, -60, 160, 80),
        4.70, //radians
        1.6, //radians
        false,
        paint1);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}