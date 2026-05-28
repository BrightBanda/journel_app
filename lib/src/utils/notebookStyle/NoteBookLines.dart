import 'package:flutter/material.dart';

class Notebooklines extends CustomPainter {
  final double lineHeight;
  final Color lineColor;

  Notebooklines({
    required this.lineHeight,
    this.lineColor = const Color.fromARGB(255, 136, 136, 136),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    double y = lineHeight;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += lineHeight;
    }
  }

  @override
  bool shouldRepaint(Notebooklines old) =>
      old.lineHeight != lineHeight || old.lineColor != lineColor;
}
