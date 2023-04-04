import 'package:flutter/material.dart';
import 'utils.dart';

class TutorialIcon extends StatelessWidget {
  const TutorialIcon(
      {Key? key,
        required this.x,
        required this.y,
        required this.icon,
      }) : super(key: key);

  final double x;
  final double y;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Utils.backgroundImageFile == null ? Colors.black12 : Colors.white.withOpacity(0),
        ),
        child: Icon(
          icon,
          size: 40,
          color: Utils.backgroundImageFile == null ? Colors.black54 : Colors.white.withOpacity(0),
        ),
      ),
    );
  }
}
