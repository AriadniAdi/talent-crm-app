import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_page.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class TalentShell extends GetView<TalentController> {
  const TalentShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('talent-shell'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final talent = controller.talent.value;

          if (talent == null) {
            return Scaffold(
              body: Center(child: Text(context.translate.talentNotFound)),
            );
          }

          return TalentPage(
            talent: talent,
          );
        },
      ),
    );
  }
}
