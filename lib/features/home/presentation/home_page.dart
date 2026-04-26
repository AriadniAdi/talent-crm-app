import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_banner.dart';
import 'widgets/home_content/home_content_view.dart';
import 'package:talent_crm_app/l10n/translate.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
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
            Obx(() => HomeBanner(
                  title: context.translate.appTitle,
                  onSearchChanged: controller.search,
                  totalTalents: controller.totalTalentsCount,
                )),
            const SizedBox(height: AppSpacing.xl),
            const HomeContentView(),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
