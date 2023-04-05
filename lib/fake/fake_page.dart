import 'dart:ui';
import 'package:fake_icon_practice/notchDisplay.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/fake/fake_model.dart';
import 'package:fake_icon_practice/performance/performance_page.dart';

class FakePage extends StatelessWidget {
  const FakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => FakeModel(),
        child: Consumer<FakeModel>(
          builder: (BuildContext context, model, Widget? child, ){
            model.displaySize = MediaQuery.of(context).size;
            model.toPerformancePage = () async {
              await Future.delayed(const Duration(milliseconds: 200));
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const PerformancePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            };
            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Utils.backgroundImageFile == null
                      ? Container(color: Colors.white)
                      : Image.file(Utils.backgroundImageFile!,
                  fit: BoxFit.fill,
                  ),
                ),
                BackdropFilter(filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onLongPress: model.onLongPress,
                    onVerticalDragStart: model.onVerticalDragStart,
                    onVerticalDragUpdate: model.onVerticalDragUpdate,
                    onVerticalDragEnd: model.onVerticalDragEnd,
                    child: AnimatedContainer(
                      curve: Curves.easeOutQuint,
                      duration: Duration(milliseconds: model.imageAnimationDuration),
                      transform: model.imageTransform,
                      child: ClipRRect(
                        borderRadius: model.borderRadius,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Utils.fakeBackgroundImageFile == null
                              ? const TutorialFake()
                              : Image.file(
                            Utils.fakeBackgroundImageFile!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Utils.addNotch ? const NotchDisplay() : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TutorialFake extends StatelessWidget {
  const TutorialFake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Utils.setUpNumber < Utils.frequencyNumber) {
      return Stack(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 70,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(FontAwesomeIcons.circleUser,
                      size: 50,
                      color: Colors.white70,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                    Icon(FontAwesomeIcons.dove,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(width: 50),
                    Text("おすすめ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 100,),
                    Text("フォロー中",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                const Divider(
                  thickness: 0.4,
                  color: Colors.white70,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(FontAwesomeIcons.circleUser,
                            size: 60,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 320,
                                child: Row(
                                  children: const [
                                    Text("FakeIcon_user",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(width: 7,),
                                    Text("@fake_icon･34分",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 300,
                                child: Text(
                                    "1.少し上にドラッグして下さい。\n　▶︎ 画面が縮小します。\n2.画面の外に出すようにドラッグして下さい\n　▶︎ 最初の画面に戻ります。",
                                    style:TextStyle(
                                      color: Colors.white70,
                                    )
                                ),
                              ),
                              Card(
                                color: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: SizedBox(
                                  width: 300,
                                  height: 400,
                                  child: Image.asset("images/tutorial-screen.png", fit: BoxFit.fill,),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(FontAwesomeIcons.comment,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.retweet,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.heart,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.chartColumn,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.share,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text(
                          "Move it as before.",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Delicious_Handrawn'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 70,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(FontAwesomeIcons.circleUser,
                      size: 50,
                      color: Colors.white70,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                    Icon(FontAwesomeIcons.dove,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(width: 50),
                    Text("おすすめ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 100,),
                    Text("フォロー中",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                const Divider(
                  thickness: 0.4,
                  color: Colors.white70,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(FontAwesomeIcons.circleUser,
                            size: 60,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 320,
                                child: Row(
                                  children: const [
                                    Text("FakeIcon_user",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(width: 7,),
                                    Text("@fake_icon･34分",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 300,
                                child: Text(
                                    "1.少し上にドラッグして下さい。\n　▶︎ 画面が縮小します。\n2.画面の外に出すようにドラッグして下さい\n　▶︎ 最初の画面に戻ります。",
                                    style:TextStyle(
                                      color: Colors.white70,
                                    )
                                ),
                              ),
                              Card(
                                color: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: SizedBox(
                                  width: 300,
                                  height: 400,
                                  child: Image.asset("images/tutorial-screen.png", fit: BoxFit.fill,),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(FontAwesomeIcons.comment,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.retweet,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.heart,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.chartColumn,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.share,
                                      size: 25,
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text(
                          "Tutorial   2 / 5",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Delicious_Handrawn'
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Behavior like closing an application.",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Delicious_Handrawn'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
