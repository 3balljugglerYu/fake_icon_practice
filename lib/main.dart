import 'package:flutter/material.dart';
import 'package:fake_icon/performance/performance_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'utils.dart';
import 'package:fake_icon/setting_splash/setting_splash_model.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (BuildContext context, Widget? widget){
        SettingSplashModel().switchOnChanged(Utils.addNotch);
        return const MyApp();
        },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PerformancePage(),

    );
  }
}