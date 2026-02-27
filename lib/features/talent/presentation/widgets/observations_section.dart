import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/voice_note_tile.dart';

import '../../../../core/design/design.dart';

class ObservationsSection extends GetView<TalentController> {
  const ObservationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                const SizedBox(width: AppSpacing.xl),
                Icon(Icons.notes, color: colors.primary),
                const SizedBox(width: AppSpacing.md),
                Text("Observações", style: theme.textTheme.titleMedium),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.toggleRecording,
              icon: Icon(
                controller.isRecording.value ? Icons.stop : Icons.mic,
              ),
              label: Text(
                controller.isRecording.value
                    ? "Parar gravação"
                    : "Gravar observação",
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (controller.voiceNotes.isEmpty)
            Text(
              "Nenhuma gravação ainda",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            )
          else
            ...controller.voiceNotes.map(
              (note) => VoiceNoteTile(
                note: note,
              ),
            ),
        ],
      ),
    );
  }
}
