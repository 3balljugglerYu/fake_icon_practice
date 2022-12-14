import 'package:fake_icon_practice/performance/performance_model.dart';
import 'package:flutter/material.dart';
import 'package:fake_icon_practice/performance/performance_page.dart';
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
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark(),
            // theme: ThemeData.dark(),
            home: Scaffold(
                body: PerformancePage()),
          );
        },
      ),
    );
  }
}