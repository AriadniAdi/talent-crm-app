import 'package:flutter/widgets.dart';

class DottedBackgroundPainter extends CustomPainter {
  final Color dotColor;

  DottedBackgroundPainter({required this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {
    const double spacing = 22;
    const double radius = 1.3;

    final paint = Paint()
      ..color = dotColor.withOpacity(0.45) // 👈 aqui controla
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
