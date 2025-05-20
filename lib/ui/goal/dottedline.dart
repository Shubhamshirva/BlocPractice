import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final bool isFirst;
  final bool isLast;

  DottedLinePainter({this.isFirst = false, this.isLast = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dotSpacing = 5.0;
    double currentY = isFirst ? dotSpacing * 2 : 0; // Start below first circle
    while (currentY < size.height - (isLast ? dotSpacing * 2 : 0)) { // End above last circle
      canvas.drawLine(Offset(size.width / 2, currentY), Offset(size.width / 2, currentY + 2), paint);
      currentY += dotSpacing * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}