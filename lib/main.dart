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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PerformanceModel>(
            create: (context) => PerformanceModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PerformancePage(),
      ),
    );
  }
}