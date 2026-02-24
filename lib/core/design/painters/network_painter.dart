import 'package:flutter/material.dart';

class NetworkPainter extends CustomPainter {
  final Color color;

  NetworkPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = size.width * 0.06
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final p1 = Offset(size.width * 0.25, size.height * 0.35);
    final p2 = Offset(size.width * 0.75, size.height * 0.30);
    final p3 = Offset(size.width * 0.55, size.height * 0.75);
    final p4 = Offset(size.width * 0.30, size.height * 0.75);

    // Conexões
    canvas.drawLine(p1, p2, linePaint);
    canvas.drawLine(p2, p3, linePaint);
    canvas.drawLine(p3, p4, linePaint);
    canvas.drawLine(p4, p1, linePaint);
    canvas.drawLine(p1, p3, linePaint);

    // Pontos
    canvas.drawCircle(p1, size.width * 0.09, dotPaint);
    canvas.drawCircle(p2, size.width * 0.09, dotPaint);
    canvas.drawCircle(p3, size.width * 0.09, dotPaint);
    canvas.drawCircle(p4, size.width * 0.09, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
