import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

class HomeSearchBar extends GetView<HomeController> {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: controller.search,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchEmployeeHint,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: AppColors.background,
          contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
