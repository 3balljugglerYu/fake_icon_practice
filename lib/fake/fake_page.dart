import 'dart:ui';
import 'package:fake_icon/notchDisplay.dart';
import 'package:fake_icon/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon/fake/fake_model.dart';
import 'package:fake_icon/performance/performance_page.dart';
import 'package:fake_icon/shared_preference_method.dart';


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
                Center(
                  child: AnimatedOpacity(
                    opacity: model.showDialog ? 1.0 : 0,
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeOutCirc,
                    child: Visibility(
                      visible: model.showDialog,
                      child: Visibility(
                        visible: Utils.isFakePagePopupVisible,
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
                            title: Text(
                              'アプリを落とすイメージで！',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            content: SizedBox(
                              height: 530.h,
                              child: Column(
                                children: [
                                  Text(
                                      ' ここはアプリ起動後の擬似的なユーザー操作画面です。\n アプリを落とすイメージで画面のやや下から少し上にドラッグし、アプリスイッチャー画面にして下さい。\n 最後に画面の外に出すイメージでスワイプして見てホーム画面に戻りましょう！',
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 20.h,),
                                  SizedBox(
                                    height: 300.h,
                                    width: 300.w,
                                    child: Image(
                                      image: AssetImage('images/tutorial-fake-page.gif'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  model.hidePopup();
                                  await SharedPreferenceMethod.saveIsFakePagePopupVisible();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                child: Text(
                                  '閉じる',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
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
                SizedBox(height: 70.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.circleUser,
                      size: 50.h,
                      color: Colors.white70,
                    ),
                    Icon(null,
                      size: 50.h,
                    ),
                    Icon(FontAwesomeIcons.dove,
                      size: 50.h,
                      color: Colors.blueGrey,
                    ),
                    Icon(null,
                      size: 50,
                    ),
                    Icon(null,
                      size: 50.h,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 50.w),
                    Text("おすすめ",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 100.w,),
                    Text("フォロー中",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 50.w),
                  ],
                ),
                Divider(
                  thickness: 0.4.h,
                  color: Colors.white70,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.0.h, right: 1.0.w, left: 1.0.w, bottom: 1.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(FontAwesomeIcons.circleUser,
                            size: 60.h,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 15.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 320.w,
                                child: Row(
                                  children: [
                                    Text("FakeIcon_user",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(width: 7.w,),
                                    Text("@fake_icon･34分",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 300.w,
                                child: Text(
                                    "1.少し上にドラッグして下さい。\n　▶︎ 画面が縮小します。\n2.画面の外に出すようにドラッグして下さい\n　▶︎ 最初の画面に戻ります。",
                                    style:TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15.sp,
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
                                  width: 300.w,
                                  height: 400.h,
                                  child: Image.asset(
                                    "images/tutorial-screen.png",
                                    fit: BoxFit.fill,
                                    color: Colors.white,
                                    colorBlendMode: BlendMode.saturation,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(FontAwesomeIcons.comment,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.retweet,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.heart,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.chartColumn,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.share,
                                      size: 25.h,
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
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 50.0.h, left: 50.0.w, right: 50.0.w, bottom: 50.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.arrowUp,
                    color: Colors.green,
                    size: 100.h,
                  ),
                  Icon(
                    FontAwesomeIcons.handPointer,
                    color: Colors.green,
                    size: 100.h,
                  ),
                  SizedBox(height: 10.h,),
                  Text("もう一度お願いします！",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto_Sans_JP',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: 70.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.circleUser,
                      size: 50.h,
                      color: Colors.white70,
                    ),
                    Icon(null,
                      size: 50.h,
                    ),
                    Icon(FontAwesomeIcons.dove,
                      size: 50.h,
                      color: Colors.blueGrey,
                    ),
                    Icon(null,
                      size: 50.h,
                    ),
                    Icon(null,
                      size: 50.h,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 50.w),
                    Text("おすすめ",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 100.w,),
                    Text("フォロー中",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 50.w),
                  ],
                ),
                Divider(
                  thickness: 0.4.h,
                  color: Colors.white70,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.0.h, right: 1.0.w, left: 1.0.w, bottom: 1.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(FontAwesomeIcons.circleUser,
                            size: 60.h,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 15.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 320.w,
                                child: Row(
                                  children: [
                                    Text("FakeIcon_user",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(width: 7.w,),
                                    Text("@fake_icon･34分",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 300.w,
                                child: Text(
                                    "1.少し上にドラッグして下さい。\n　▶︎ 画面が縮小します。\n2.画面の外に出すようにドラッグして下さい\n　▶︎ 最初の画面に戻ります。",
                                    style:TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15.sp,
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
                                  width: 300.w,
                                  height: 400.h,
                                  child: Image.asset(
                                    "images/tutorial-screen.png",
                                    fit: BoxFit.fill,
                                    color: Colors.white,
                                    colorBlendMode: BlendMode.saturation,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(FontAwesomeIcons.comment,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.retweet,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.heart,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.chartColumn,
                                      size: 25.h,
                                      color: Colors.white70,
                                    ),
                                    Icon(FontAwesomeIcons.share,
                                      size: 25.h,
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
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 50.0.h, left: 50.0.w, right: 50.0.w, bottom: 50.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.arrowUp,
                    color: Colors.green,
                    size: 100.h,
                  ),
                  Icon(
                    FontAwesomeIcons.handPointer,
                    color: Colors.green,
                    size: 100.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
