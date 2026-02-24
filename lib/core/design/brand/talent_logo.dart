import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/painters/network_painter.dart';

class TalentLogo extends StatelessWidget {
  final double size;
  const TalentLogo({
    super.key,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.4),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.35),
            blurRadius: size * 0.35,
            offset: Offset(0, size * 0.15),
          ),
        ],
      ),
      child: CustomPaint(
        painter: NetworkPainter(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
