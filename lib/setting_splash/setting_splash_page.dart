import 'dart:ui';
import 'package:fake_icon_practice/setting_splash/setting_splash_model.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_switch/flutter_switch.dart';

class SettingSplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingSplashModel>(
      create: (_) => SettingSplashModel(),
      builder: (context, snapshot) {
        Size displaySize = MediaQuery.of(context).size;
        print(displaySize.height);
        print(displaySize.width);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Opacity(
              opacity: 0.95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  IconButton(
                    onPressed: () async {
                      if (Utils.comeBackSecond <= Utils.notifySecond ||
                          Utils.transitionSecond <= Utils.notifySecond) {
                        await _showDialog2(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                    ),
                    iconSize: 30.0,
                  ),
                  const Spacer(),
                  const Icon(
                    FontAwesomeIcons.ship,
                    size: 35,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Text(
                    'Splash App',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 55,
                  ),
                ],
              ),
            ),
          ),
          body: Consumer<SettingSplashModel>(builder: (context, model, child) {
            return Column(
              children: [
                //画面上部ブロック
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "画面設定",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text("ロゴ設定"),
                                SizedBox(
                                  width: displaySize.height >= 800
                                      ? displaySize.width / 4
                                      : displaySize.width / 4.8,
                                  height: displaySize.height >= 800
                                      ? displaySize.width / 4
                                      : displaySize.width / 4.8,
                                  child: Utils.logoImageFile == null
                                      ? Image.asset(
                                    'images/line-logo.png',
                                    fit: BoxFit.fill,
                                  )
                                      : Image.file(
                                    Utils.logoImageFile!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    elevation: 5.0,
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          await model.getLogo();
                                        } catch (e) {
                                          if (e.toString() !=
                                              'Null check operator used on a null value') {
                                            await _showDialog(context);
                                          }
                                        }
                                      },
                                      child: const Center(
                                        child: Text(
                                          "画像設定",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("起動時の画面"),
                                SizedBox(
                                  width: displaySize.height >= 800
                                      ? displaySize.width / 4
                                      : displaySize.width / 4.7,
                                  height: displaySize.height >= 800
                                      ? displaySize.height / 4.2
                                      : displaySize.width / 2.7,
                                  child: Utils.fakeColorFile == null
                                      ? Image.asset(
                                    'images/splash-app-1.png',
                                    fit: BoxFit.fill,
                                  )
                                      : Image.file(
                                    Utils.fakeColorFile!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    elevation: 5.0,
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          await model.getFakeColor();
                                        } catch (e) {
                                          if (e.toString() !=
                                              'Null check operator used on a null value') {
                                            await _showDialog(context);
                                          }
                                        }
                                      },
                                      child: const Center(
                                        child: Text(
                                          "画像設定",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("起動後の画面"),
                                SizedBox(
                                  width: displaySize.height >= 800
                                      ? displaySize.width / 4
                                      : displaySize.width / 4.7,
                                  height: displaySize.height >= 800
                                      ? displaySize.height / 4.2
                                      : displaySize.width / 2.7,
                                  child: Utils.fakeImageFile == null
                                      ? Image.asset(
                                    'images/default_fake_page.png',
                                    fit: BoxFit.fill,
                                  )
                                      : Image.file(
                                    Utils.fakeImageFile!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    elevation: 5.0,
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          await model.getFakeImage();
                                        } catch (e) {
                                          if (e.toString() !=
                                              'Null check operator used on a null value') {
                                            await _showDialog(context);
                                          }
                                        }
                                      },
                                      child: const Center(
                                        child: Text(
                                          "画像設定",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //画面下部ブロック
                Expanded(
                  flex: 4,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      margin: const EdgeInsets.only(right: 15.0, left: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SettingNumSec(
                                title: "改め回数",
                                change: model.freNumToStr(),
                                selectedItemChange: model.onSelectedItemChanged,
                                arrange: model.freNum,
                                num: Utils.frequencyNumber,
                                unit: "回",
                                explain:
                                "普通のアプリであることを伝えるために、アプリを起動したり落としたりを繰り返すための回数を設定します。"),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                            SettingNumSec(
                              title: "ロゴ消失後の復帰時間",
                              change: model.comSecToStr(),
                              selectedItemChange: model.onSelectedItemChanged2,
                              arrange: model.comSec,
                              num: Utils.comeBackSecond,
                              unit: "秒",
                              explain:
                              "設定したロゴを画面外に動かした後、指定した秒数後にロゴが元の場所に戻ります。その秒数を設定します。",
                            ),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                            SettingNumSec(
                                title: "復帰後からの画面遷移時間",
                                change: model.traSecToStr(),
                                selectedItemChange:
                                model.onSelectedItemChanged3,
                                arrange: model.traSec,
                                num: Utils.transitionSecond,
                                unit: "秒",
                                explain:
                                "ロゴが元の位置に戻った後、指定した起動後の画面に移ります。この起動後の画面に移るまでの秒数を設定します。"),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                            SettingNumSec(
                                title: "お知らせタイマー",
                                change: model.setSecToStr(),
                                selectedItemChange:
                                model.onSelectedItemChanged4,
                                arrange: model.setSec,
                                num: Utils.notifySecond,
                                unit: "秒前",
                                explain:
                                "「ロゴ消失後の復帰時間」ど「復帰後からの遷移時間」で設定した時間に達する前に、バイブでしらせます。"),
                            // Divider(
                            //   thickness: 0.2,
                            //   color: Colors.grey,
                            // ),
                            // Column(
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text(
                            //           'お好みスイッチ',
                            //           style: TextStyle(
                            //               fontSize: 18.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //         Container(
                            //           height: 31,
                            //           width: 105,
                            //           alignment: Alignment.bottomCenter,
                            //           child: FlutterSwitch(
                            //               width: 60,
                            //               height: 30,
                            //               value: Utils.isCanVolumeSwitch,
                            //               onToggle: (value) {
                            //                 model.changeToggle(value);
                            //               }),
                            //         ),
                            //       ],
                            //     ),
                            //     Text(
                            //       'ボリュームボタンで、ロゴの消失から復帰させることができ、また次の画面へ遷移させることができます。',
                            //       style: TextStyle(fontSize: 12),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //完了ボタン
                SizedBox(
                  height: 45,
                  width: 250.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (Utils.comeBackSecond <= Utils.notifySecond ||
                          Utils.transitionSecond <= Utils.notifySecond) {
                        await _showDialog2(context);
                      } else {
                        // await model.saveSplashSettingElement();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                    child: const Text(
                      "完了",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            );
          }),
        );
      },
    );
  }

  Future _showDialog(
      BuildContext context,
      ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("写真の設定"),
          content: Text("画像の設定には端末の設定からFake_Icon_Appの写真へのアクセスを許可してください。"),
        );
      },
    );
  }

  Future _showDialog2(
      BuildContext context,
      ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("設定エラー"),
          content:
          Text("「お知らせタイマー」は、「ロゴ消失後の復帰時間」や「復帰後からの画面遷移時間」よりも、秒数を短く設定してください。"),
        );
      },
    );
  }
}

class SettingNumSec extends StatelessWidget {
  SettingNumSec({
    required this.title,
    required this.change,
    required this.selectedItemChange,
    required this.arrange,
    required this.num,
    required this.unit,
    required this.explain,
  });

  final String title;
  dynamic change;
  dynamic selectedItemChange;
  dynamic arrange;
  final int num;
  final String unit;
  final String explain;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingSplashModel>(
      create: (_) => SettingSplashModel(),
      builder: (context, snapshot) {
        return Consumer<SettingSplashModel>(builder: (context, model, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: title != '改め回数'
                          ? Colors.black12
                          : null,
                    ),
                  ),
                  Container(
                    height: 31,
                    width: 105,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                            ))),
                    child: InkWell(
                      onTap: () {
                        if (title != '改め回数') {
                          return;
                        }
                        change;
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 300,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 65,
                                        ),
                                        const Spacer(),
                                        Material(
                                          child: Text(
                                            title,
                                            style:
                                            const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        const Spacer(),
                                        CupertinoButton(
                                            child: const Text("完了️"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ),
                                    const Divider(),
                                    Expanded(
                                      child: CupertinoPicker(
                                        scrollController:
                                        FixedExtentScrollController(
                                            initialItem: title != "お知らせタイマー"
                                                ? num - 1
                                                : num),
                                        looping: false,
                                        itemExtent: 50,
                                        onSelectedItemChanged: (int value) {
                                          selectedItemChange(value);
                                        },
                                        // children: arrange,
                                        children: arrange,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 22,
                            width: 22,
                            child: Center(
                                child: Text(
                                  "▼",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: title != '改め回数'
                                          ? Colors.black12
                                          : null),
                                )),
                          ),
                          Text(
                            num.toString(),
                            style: TextStyle(
                                fontSize: 30,
                                color:
                                title != '改め回数'
                                    ? Colors.black12
                                    : null),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: 32,
                            child: Text(
                              unit,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  title != '改め回数'
                                      ? Colors.black12
                                      : null),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                explain,
                style: TextStyle(
                    fontSize: 12.0,
                    color:title != '改め回数'
                        ? Colors.black12
                        : null),
              ),
            ],
          );
        });
      },
    );
  }
}
