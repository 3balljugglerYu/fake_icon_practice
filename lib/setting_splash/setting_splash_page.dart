import 'package:fake_icon/setting_splash/setting_splash_model.dart';
import 'package:fake_icon/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon/shared_preference_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingSplashPage extends StatelessWidget {
  const SettingSplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingSplashModel>(
      create: (_) => SettingSplashModel(),
      builder: (context, snapshot){
        Size displaySize = MediaQuery.of(context).size;
        return Consumer<SettingSplashModel>(builder: (context, model, child){
          return Scaffold(
          body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 25.0.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                      margin: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.w),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.gears,
                            size: 18.h,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 10.w,),
                          Text(
                            "画面設定",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 10.w),
                        margin: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0))
                        ),
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: 30.0.h,
                            // ),
                            // Container(
                            //   alignment: Alignment.topLeft,
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         FontAwesomeIcons.ship,
                            //         size: 18.h,
                            //         color: Colors.black54,
                            //       ),
                            //       SizedBox(width: 10.w,),
                            //       Text(
                            //         "画面設定",
                            //         style: TextStyle(
                            //             fontSize: 18.sp,
                            //             fontWeight: FontWeight.bold,
                            //             color: Colors.black54
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("ロゴ設定",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: displaySize.width / 4,
                                      height: displaySize.width / 4,
                                      child: Utils.splashLogoImageFile == null
                                          ? Image.asset("images/tutorial-splash-logo.png", fit: BoxFit.fill,)
                                          : Image.file(Utils.splashLogoImageFile!,fit: BoxFit.fill,),
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                      height: 35.h,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 2.0,
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              await model.getSplashLogoImageFile();
                                            } catch (e){
                                              await _showDialog(context);
                                            }
                                          },
                                          child: Center(
                                            child: Text("画面設定",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    IconButton(
                                      iconSize: 30.h,
                                      onPressed: (){model.tutorialSplashCreate();},
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 35.h,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("起動時の画面",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: displaySize.width / 4.5,
                                      height: displaySize.height / 4.5,
                                      child: Utils.splashBackgroundImageFile == null
                                          ? Image.asset("images/tutorial-splash-bg.png", fit: BoxFit.fill,)
                                          : Image.file(Utils.splashBackgroundImageFile!,fit: BoxFit.fill,),
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                      height: 35.h,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 2.0,
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              await model.getSplashBackgroundImageFile();
                                            } catch (e){
                                              await _showDialog(context);
                                            }
                                          },
                                          child: Center(
                                            child: Text("画面設定",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "起動後の画面",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: displaySize.width / 4.5,
                                      height: displaySize.height / 4.5,
                                      child: Utils.fakeBackgroundImageFile == null
                                          ? Image.asset("images/tutorial-fake-bg.png", fit: BoxFit.fill,)
                                          : Image.file(Utils.fakeBackgroundImageFile!,fit: BoxFit.fill,),
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                      height: 35.h,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 2.0,
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              await model.getFakeBackgroundImageFile();
                                            } catch (e){
                                              await _showDialog(context);
                                            }
                                          },
                                          child: Center(
                                            child: Text("画面設定",
                                              style: TextStyle(fontSize: 13.sp,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.2.h,
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(right: 10.0.w, left: 10.0.w),
                            margin: EdgeInsets.only(right: 15.0.w, left: 15.0.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0)),
                            ),
                            child: Column(
                              children: [
                                SettingNumSec(
                                  title: "改め回数",
                                  setList: model.freNumToStr(),
                                  selectedItemChange: model.onSelectedFrequencyNumChanged,
                                  listNum: model.freNum,
                                  unit: "回",
                                  setNum: Utils.frequencyNumber,
                                  cupertinoPickerInitialNum: Utils.frequencyNumber,
                                  explain: "スプラッシュスクリーンで止めるまでの回数です。\n通常のアプリだと思わせる為に設定します。",
                                ),
                                SettingNumSec(
                                  title: "ロゴの復帰時間",
                                  setList: model.comSecToStr(),
                                  selectedItemChange: model.onSelectedComebackLogoNumChanged,
                                  listNum: model.comSec,
                                  unit: "秒",
                                  setNum: Utils.comeBackSecond,
                                  cupertinoPickerInitialNum: Utils.comeBackSecond,
                                  explain: "ロゴを画面外に出した後の戻ってくるまでの時間を設定します。",
                                ),
                                SettingNumSec(
                                  title: "ロゴ復帰後からの遷移時間",
                                  setList: model.traSecToStr(),
                                  selectedItemChange: model.onSelectedTransitionNumChanged,
                                  listNum: model.traSec,
                                  unit: "秒",
                                  setNum: Utils.transitionSecond,
                                  cupertinoPickerInitialNum: Utils.transitionSecond,
                                  explain: "ロゴが戻ってから上記で設定した『起動後の画面』に移るまでの時間を設定します。",
                                ),
                                SettingNumSec(
                                  title: "お知らせタイマー",
                                  setList: model.setSecToStr(),
                                  selectedItemChange: model.onSelectedNotifyNumChanged,
                                  listNum: model.setSec,
                                  unit: "秒前",
                                  setNum: Utils.notifySecond,
                                  cupertinoPickerInitialNum: Utils.notifySecond,
                                  explain: "『ロゴの復帰時間』や『復帰後からの画面遷移時間』に移る時にバイブでお知らせしてくれます。\n『ロゴの復帰時間』や『復帰後からの画面遷移時間』よりも短く設定する必要があります。",
                                ),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SwitchListTile.adaptive(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            "ノッチの表示",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "ダークモード推奨です。\nスクショでの背景画像ですと時刻やバッテリー残量まで画像として保存される為、隠す目的で使用します。",
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 10.sp
                                            ),
                                          ),
                                          value: Utils.addNotch,
                                          onChanged: model.switchOnChanged,
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 0.2.h,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    SizedBox(
                      height: 45.0.h,
                      width: 250.0.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(Utils.notifySecond != 0){
                            if(Utils.comeBackSecond <= Utils.notifySecond ||
                                Utils.transitionSecond <= Utils.notifySecond){
                              await _showDialog2(context);
                            } else {
                              await SharedPreferenceMethod.saveSplashSettingElement();
                              Navigator.pop(context);
                            }
                          } else {
                            await SharedPreferenceMethod.saveSplashSettingElement();
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black54,
                        ),
                        child: Text(
                          "完了",
                          style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0.h,
                    )
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  top: MediaQuery.of(context).size.height/6,
                  left: model.tutorialSplashImageCreate ? 0 : MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 10,
                            blurRadius: 10,
                          ),
                        ],
                        color: Colors.white.withOpacity(0.9),
                      ),
                      height: 500.h,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                            child: model.tutorialSplashImageCreate ? const Image(
                              image: AssetImage('images/tutorial-splash-image-create.gif'),
                            ) : null,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  " Tutorial",
                                  style: TextStyle(fontSize: 24.sp),
                                ),
                              ),
                              IconButton(
                                iconSize:  150.h,
                                onPressed: (){model.tutorialSplashCreate();},
                                icon: Icon(
                                  Icons.play_arrow_sharp,
                                  size: 50.h,
                                  color: Colors.black45,
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  "          ",
                                  style: TextStyle(fontSize: 24.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },);
      },
    );
  }

  Future _showDialog(BuildContext context) async {
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

class SettingSwitch extends StatelessWidget {
  SettingSwitch({
    super.key,
    required this.title,
    required this.explain,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String explain;
  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SwitchListTile.adaptive(
                    value: value,
                    onChanged: onChanged,
                )
              ],
            ),
            Text(
              explain,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            Divider(
              thickness: 0.2.h,
              color: Colors.black54,
            ),
          ],
        )
      ],
    );
  }
}


class SettingNumSec extends StatelessWidget {
  SettingNumSec({
      super.key,
      required this.title,
      required this.setList,
      required this.selectedItemChange,
      required this.listNum,
      required this.unit,
      required this.setNum,
      required this.explain,
      required this.cupertinoPickerInitialNum,
    });

    final String title;
    dynamic setList;
    dynamic selectedItemChange;
    dynamic listNum;
    final String unit;
    final int setNum;
    final String explain;
    final int cupertinoPickerInitialNum;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  width: 105.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      setList;
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context){
                          return Container(
                            height: 300.h,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 65.w,
                                    ),
                                    const Spacer(),
                                    Material(
                                      color: Colors.white,
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    CupertinoButton(
                                      child: const Text(
                                          "完了",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Expanded(
                                  child: CupertinoPicker(
                                    scrollController: FixedExtentScrollController(
                                      initialItem: cupertinoPickerInitialNum,
                                    ),
                                    backgroundColor: Colors.white,
                                    looping: false,
                                    itemExtent: 50.sp,
                                    onSelectedItemChanged: (int value){
                                      selectedItemChange(value);
                                    },
                                    children: listNum,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 22.w,
                          child: Center(
                            child: Text(
                              "▼",
                              style: TextStyle(
                                fontSize: 20.0.sp,
                                color: Colors.black54,
                              ),),
                          ),
                        ),
                        Text(
                          setNum.toString(),
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black54,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          width: 32.w,
                          child: Text(
                            unit,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              explain,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 10.sp
              ),

            ),
            Divider(
              thickness: 0.2.h,
              color: Colors.black54,
            ),
          ],
        )
      ],
    );
  }
}
