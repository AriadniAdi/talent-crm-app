import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';
import 'home_content.dart';

class HomeContentView extends GetView<HomeController> {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.screenError.value != null &&
          controller.allEmployees.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline,
                  size: 40, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: AppSpacing.md),
              Text(controller.screenError.value!.message(context)),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: controller.fetchEmployees,
                child: Text(AppLocalizations.of(context)!.tryAgain),
              ),
            ],
          ),
        );
      }

      if (controller.allEmployees.isEmpty) {
        return Center(
          child: Text(AppLocalizations.of(context)!.noEmployeesFound),
        );
      }

      return HomeContent(
        recent: controller.recentEmployees,
        all: controller.allEmployees,
      );
    });
  }
}
