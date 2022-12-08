import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'setting_top_model.dart';
import 'package:fake_icon_practice/utils.dart';
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
                children: const [
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
          body: Consumer<SettingTopModel>(
            builder: (context, model, child){


            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Utils.backgroundImageFile == null ? null : Image.file(Utils.backgroundImageFile!,fit: BoxFit.fill,)
                  // child: ImageFiltered(
                  //   imageFilter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                  //   child: Image.asset("images/performance-page.jpg",
                  //   fit: BoxFit.fill,
                  //   ),
                  // ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 150,
                        child: Card(
                          shadowColor: Colors.black,
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
                              } catch (e){

                              }
                            },
                            child: Column(
                              children: const [
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
                      ),
                      SizedBox(
                        height: 150,
                        child: Card(
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 10.0,
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.icons,
                                  size: 35,
                                ),
                                title: Text(
                                  "アイコンの配置変更",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                subtitle: Text(
                                  "背景画像の設定後、アイコンの位置を決める設定を行います。任意の位置に配置することが可能です。",
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: Card(
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 10.0,
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.ship,
                                  size: 35,
                                ),
                                title: Text(
                                  "Splash App 設定",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                subtitle: Text(
                                  "ロゴや背景画像の変更、ロゴを消失させた後に表示させるタイミング等を設定することができます。",
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              )
                            ],
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
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('完了',
                            style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
            },
          ),
        );
      },
    );
  }
}
