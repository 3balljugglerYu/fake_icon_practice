import 'package:flutter/material.dart';

class ReusableMoveIcon extends StatelessWidget {
  const ReusableMoveIcon(
      {Key? key,
      required this.x,
      required this.y,
      required this.icon,
      this.iconBackgroundColor,
      this.iconColor,
      required this.onDragEnd})
      : super(key: key);

  final double x;
  final double y;
  final IconData icon;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final dynamic onDragEnd;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: x,
        top: y,
        child: Draggable(
          feedback: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade300.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                  offset: const Offset(10, 10),
                )
              ]
            ),
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                icon,
                size: 40,
              ),
            ),
          ),
          childWhenDragging: Container(),
          onDragEnd: onDragEnd,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: iconBackgroundColor ?? Colors.white,
            ),
            child: Icon(
              icon,
              size: 40,
              color: iconColor ?? Colors.black,
            ),
          ),
        ),
    );
  }
}