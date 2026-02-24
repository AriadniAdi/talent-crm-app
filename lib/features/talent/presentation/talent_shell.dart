import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_page.dart';

class TalentShell extends GetView<TalentController> {
  const TalentShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final talent = controller.talent.value;
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (talent == null) {
        return const Scaffold(
          body: Center(child: Text('Talent not found')),
        );
      }

      return TalentPage(
        talent: talent,
        voiceNotes: controller.voiceNotes.toList(),
        onRecord: controller.recordNote,
      );
    });
  }
}
