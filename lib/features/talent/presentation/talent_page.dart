import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/animations/fade_slide.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
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
            FadeSlide(
              child: TalentHeaderBanner(
                avatarUrl: talent.avatarUrl,
                title: talent.name,
                subtitle: talent.description,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            InfoCard(talent: talent),
            const SizedBox(height: AppSpacing.md),
            ObservationsSection(talentId: talent.id.toString()),
          ],
        ),
      ),
    );
  }
}
