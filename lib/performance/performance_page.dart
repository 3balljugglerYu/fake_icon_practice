import 'package:fake_icon_practice/performance/performance_model.dart';
import 'package:fake_icon_practice/setting_top/setting_top_page.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final PerformanceModel performanceModel = Provider.of<PerformanceModel>(context, listen: true);
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
                  left: 170,
                  top: 580,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: const Text('Button'),
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => SettingTopPage()));
                        model.notifyListeners();
                      },
                    ),
                  ),
                )
              ],
            );
          },
          ),
        ),
    );

  }
}
