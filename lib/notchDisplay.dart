import 'package:flutter/material.dart';

class NotchDisplay extends StatelessWidget {
  const NotchDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0,bottom: 0,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).padding.top * 1.1,
                color: Colors.black54,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      painter: RightPainter(),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      painter: LeftPainter(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 120;
    canvas.drawArc(
        const Rect.fromLTRB(-60, -60, 80, 80),
        3.14, //radians
        1.6, //radians
        false,
        paint1);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LeftPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 120;
    canvas.drawArc(
        const Rect.fromLTRB(20, -60, 160, 80),
        4.70, //radians
        1.6, //radians
        false,
        paint1);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
