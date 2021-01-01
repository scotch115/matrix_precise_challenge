import 'package:flutter/material.dart';

class StopPosition extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(148, 164, 165, 1)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(Offset(100, 100) & Size(120, 20), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
