import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'widgets/home_content/home_content_view.dart';
import 'widgets/home_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSpacing.lg),
            HomeSearchBar(),
            SizedBox(height: AppSpacing.xl),
            HomeContentView(),
          ],
        ),
      ),
    );
  }
}
