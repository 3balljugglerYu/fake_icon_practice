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
    Position.defaultPosition(context);

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
                  child: Utils.backgroundImageFile == null ? Image.asset('images/splash-app-1.png',
                    fit: BoxFit.fill,
                  ) : Image.file(
                    Utils.backgroundImageFile!,
                  ),
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
                        child: Text('splash'),
                        onPressed: () async {
                          await model.onPressed();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FakePage()));
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
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => SettingTopPage()));
                        model.notifyListeners();
                      },
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
