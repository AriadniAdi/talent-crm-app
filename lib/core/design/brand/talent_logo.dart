import 'package:flutter/material.dart';

class TalentLogo extends StatelessWidget {
  const TalentLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6E5CFF), // Roxo
            Color(0xFF3C8DFF), // Azul
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6E5CFF).withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _NetworkPainter(),
      ),
    );
  }
}

class _NetworkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 1.8
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
    canvas.drawCircle(p1, 3.5, dotPaint);
    canvas.drawCircle(p2, 3.5, dotPaint);
    canvas.drawCircle(p3, 3.5, dotPaint);
    canvas.drawCircle(p4, 3.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
