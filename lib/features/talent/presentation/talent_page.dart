import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/widgets/base_page.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/info_card.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/observations_section.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/talent_header_banner.dart';

import '../../../core/design/design.dart';

class TalentPage extends StatelessWidget {
  final Talent talent;

  const TalentPage({
    super.key,
    required this.talent,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppFadeSlide(
              child: TalentHeaderBanner(
                avatarUrl: talent.avatarUrl,
                title: talent.name,
                subtitle: talent.description,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            InfoCard(talent: talent),
            const SizedBox(height: AppSpacing.md),
            const ObservationsSection(),
          ],
        ),
      ),
    );
  }
}

class AppFadeSlide extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double dy;

  const AppFadeSlide({
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
