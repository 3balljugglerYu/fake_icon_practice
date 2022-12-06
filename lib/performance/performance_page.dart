import 'package:fake_icon_practice/performance/performance_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PerformanceModel performanceModel = Provider.of<PerformanceModel>(context, listen: true);
    return Stack(
      children: [
        SizedBox(
          child: Image.asset('images/performance-page.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
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
              onPressed: (){},
            ),
          ),
        )
      ],
    );
  }
}
