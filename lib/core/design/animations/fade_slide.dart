import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';

class FadeSlide extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double dy;

  const FadeSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.dy = AppSpacing.sm,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (context, t, _) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * dy),
            child: child,
          ),
        );
      },
    );
  }
}
