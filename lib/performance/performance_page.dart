import 'package:fake_icon_practice/performance/performance_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PerformanceModel performanceModel = Provider.of<PerformanceModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo Home Page"),
      ),
      body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  performanceModel.counter.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: performanceModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
