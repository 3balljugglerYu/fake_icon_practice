import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'setting_top_model.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fake_icon_practice/setting_put_icon/setting_put_icon_page.dart';
import 'package:fake_icon_practice/setting_splash/setting_splash_page.dart';
import 'package:fake_icon_practice/shared_preference_method.dart';
import 'package:fake_icon_practice/tutorial_icon.dart';

class SettingTopPage extends StatelessWidget {
  const SettingTopPage({super.key});

  @override
  Widget build(BuildContext context) {
    //データが変わったことを知りWidgetを作り直す。ChangeNotifierProvider
    return ChangeNotifierProvider<SettingTopModel>(
      create: (_) => SettingTopModel(),
      builder: (context, model){
        return Consumer<SettingTopModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Opacity(
                opacity: 0.95,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      FontAwesomeIcons.gears,
                      size: 35,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 15.0),
                    const Text(
                      '設定',
                      style: TextStyle(fontSize: 30,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 55,
                    )
                  ],
                ),
              ),
            ),
            body: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Utils.backgroundImageFile == null
                          ? Container()
                          : Image.file(
                        Utils.backgroundImageFile!, fit: BoxFit.fill,
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.white,
                              shadowColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0,
                              ),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () async {
                                  try {
                                    await model.getImage();
                                  } catch (e) {
                                    if (e.toString() !=
                                        'Null check operator used on a null value') {
                                      await showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text('写真の設定'),
                                              content: Text(
                                                  '画像の設定には端末の設定から写真へのアクセスを許可して下さい。'),
                                            );
                                          });
                                    }
                                  }
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        FontAwesomeIcons.mobile,
                                        size: 35,
                                        color: Colors.black45,
                                      ),
                                      trailing: IconButton(
                                        iconSize: 30,
                                        onPressed: (){model.tutorialBgChange();},
                                        icon: const Icon(
                                          Icons.info_outline,
                                          size: 30,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      title: const Text(
                                        "背景画像設定",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black54,
                                        ),

                                      ),
                                      subtitle: const Text(
                                        "アプリ起動時の画面を設定します。自身のホーム画面のスクショを設定して下さい。",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.white,
                              shadowColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0,
                              ),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          SettingPutIconPage()));
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        FontAwesomeIcons.arrowsUpDownLeftRight,
                                        size: 35,
                                        color: Colors.black45,
                                      ),
                                      trailing: IconButton(
                                        iconSize: 30,
                                        onPressed: (){model.tutorialIconChange();},
                                        icon: const Icon(
                                          Icons.info_outline,
                                          size: 30,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      title: const Text(
                                        "アイコンの配置変更",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      subtitle: const Text(
                                        "アイコンの位置を変更します。背景画像設定で設定した画像のアイコンに合わせましょう。",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.white,
                              shadowColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0,
                              ),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingSplashPage()));
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        FontAwesomeIcons.ship,
                                        size: 35,
                                        color: Colors.black45,
                                      ),
                                      trailing: IconButton(
                                        iconSize: 30,
                                        onPressed: (){model.tutorialSplashDemo();},
                                        icon: const Icon(
                                          Icons.info_outline,
                                          size: 30,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      title: const Text(
                                        "Splash App 設定",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      subtitle: const Text(
                                        "ロゴや背景画像の変更、ロゴを消失させた後に表示させるタイミング等を設定することができます。",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: ElevatedButton(
                              onPressed: () async {
                                await SharedPreferenceMethod
                                    .saveBackgroundImageFile();
                                Utils.setUpNumber = 0;
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('完了',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      top: MediaQuery.of(context).size.height/5,
                      left: model.tutorialBg ? 0 : MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(10,10),
                                ),
                              ],
                          color: Colors.blueGrey.withOpacity(0.9),
                          ),
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: model.tutorialBg ? const Image(
                                  image: AssetImage('images/tutorial-background-change.gif'),
                                ) : null,
                              ),
                              IconButton(
                                iconSize:  150,
                                onPressed: (){model.tutorialBgChange();},
                                icon: const Icon(
                                  Icons.play_arrow_sharp,
                                  size: 50,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      top: MediaQuery.of(context).size.height/5,
                      left: model.tutorialIcon ? 0 : MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(10,10),
                              ),
                            ],
                            color: Colors.blueGrey.withOpacity(0.9),
                          ),
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: model.tutorialIcon ? const Image(
                                  image: AssetImage('images/tutorial-icon-change.gif'),
                                ) : null,
                              ),
                              IconButton(
                                iconSize:  150,
                                onPressed: (){model.tutorialIconChange();},
                                icon: const Icon(
                                  Icons.play_arrow_sharp,
                                  size: 50,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      top: MediaQuery.of(context).size.height/5,
                      left: model.tutorialSplash ? 0 : MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(10,10),
                              ),
                            ],
                            color: Colors.blueGrey.withOpacity(0.9),
                          ),
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: model.tutorialSplash ? const Image(
                                  image: AssetImage('images/tutorial-splash-demo.gif'),
                                ) : null,
                              ),
                              IconButton(
                                iconSize:  150,
                                onPressed: (){model.tutorialSplashDemo();},
                                icon: const Icon(
                                  Icons.play_arrow_sharp,
                                  size: 50,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: Center(
                        child: AnimatedOpacity(
                          opacity: model.showDialog ? 1.0 : 0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOutCirc,
                          child: Visibility(
                            visible: model.showDialog,
                            child: Visibility(
                              visible: Utils.isSettingTopPagePopupVisible,
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
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.info_outline),
                                      Text(' をタップ！'),
                                    ],
                                  ),
                                  content: const Text('各項目の設定方法を動画で見ることができますので参考にして下さい！\n\nこれでチュートリアルは終了です！\nマジックのネタの一つとして活用して頂けると嬉しいです！'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        model.hidePopup();
                                        await SharedPreferenceMethod.saveIsSettingTopPagePopupVisible();
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
                    ),
                  ],
                ),
          );
        },
        );
      },
    );
  }
}
