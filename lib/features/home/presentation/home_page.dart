import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_banner.dart';
import 'widgets/home_content/home_content_view.dart';
import 'widgets/home_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            const HomeSearchBar(),
            const SizedBox(height: AppSpacing.xl),
            HomeBanner(
              title: 'Connect with top talents',
              subtitle: 'Explore professionals, teams and skills in one place.',
              buttonText: 'View Profiles',
              onPressed: () {},
            ),
            const SizedBox(height: AppSpacing.xl),
            const HomeContentView(),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
