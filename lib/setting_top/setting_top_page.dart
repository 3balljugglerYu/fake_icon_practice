import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'setting_top_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingTopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //データが変わったことを知りWidgetを作り直す。ChangeNotifierProvider
    return ChangeNotifierProvider<SettingTopModel>(
      create: (_) => SettingTopModel(),
      builder: (context, model){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Opacity(
              opacity: 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Icon(
                    FontAwesomeIcons.gears,
                    size: 35,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    '設定',
                    style: TextStyle(fontSize: 24,color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                  child: Image.asset("images/performance-page.jpg",
                  fit: BoxFit.fill,
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 150,
                      child: Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.mobile,
                                size: 35,
                              ),
                              title: Text(
                                "背景画像設定",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Text(
                                "アプリを立ち上げた時、最初に表示される画面を設定します。自分が使用しているスマートフォンのスクリーンショットを用意することをお勧めします。",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
