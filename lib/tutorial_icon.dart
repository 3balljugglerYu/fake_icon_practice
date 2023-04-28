import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TutorialIcon extends StatelessWidget {
  const TutorialIcon(
      {Key? key,
        required this.x,
        required this.y,
        required this.icon,
        required this.iconSize,
        required this.contColor,
        required this.iconColor,
      }) : super(key: key);

  final double x;
  final double y;
  final IconData icon;
  final double iconSize;
  final Color contColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: 65.w,
        height: 65.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Utils.backgroundImageFile == null ? contColor : Colors.white.withOpacity(0),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: Utils.backgroundImageFile == null ? iconColor : Colors.white.withOpacity(0),
        ),
      ),
    );
  }
}
