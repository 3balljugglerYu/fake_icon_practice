import 'package:fake_icon/performance/performance_model.dart';
import 'package:flutter/material.dart';
import 'package:fake_icon/performance/performance_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PerformanceModel(),
      child: Consumer<PerformanceModel>(
        builder: (context,theme,_){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch:blackSwatch,
            ),
            darkTheme: ThemeData(
              primarySwatch:whiteSwatch,
            ),
            themeMode: ThemeMode.system,
            // theme: ThemeData.dark(),
            home: const Scaffold(
                body: PerformancePage()),
          );
        },
      ),
    );
  }
}

const int white = 0xFFFFFFFF;
const MaterialColor whiteSwatch = MaterialColor(
  white,
  <int, Color> {
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

const int black = 0xff000000;
const MaterialColor blackSwatch = MaterialColor(
  black,
  <int, Color> {
    50: Color(0xff000000),
    100: Color(0xff000000),
    200: Color(0xff000000),
    300: Color(0xff000000),
    400: Color(0xff000000),
    500: Color(0xff000000),
    600: Color(0xff000000),
    700: Color(0xff000000),
    800: Color(0xff000000),
    900: Color(0xff000000),
  },
);
