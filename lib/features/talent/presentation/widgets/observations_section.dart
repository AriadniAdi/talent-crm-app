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
    final ColorScheme colors = Theme.of(context).colorScheme;
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(theme: theme, colors: colors),
        const SizedBox(height: AppSpacing.lg),
        _recordingButton(),
        const SizedBox(height: AppSpacing.xl),
        _audioError(theme: theme, colors: colors),
        const SizedBox(height: AppSpacing.md),
        _voicesNotesList(context: context),
      ],
    );
  }

  Widget _header({required ThemeData theme, required ColorScheme colors}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.xl),
          Icon(Icons.notes, color: colors.primary),
          const SizedBox(width: AppSpacing.md),
          Text("Observações", style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _recordingButton() {
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        return ElevatedButton.icon(
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
        );
      }),
    );
  }

  _audioError({required ThemeData theme, required ColorScheme colors}) {
    return Obx(() {
      if (controller.voiceNotes.isEmpty) {
        return Text(
          "Nenhuma gravação ainda",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
        );
      }

      return Column(
        children: controller.voiceNotes
            .map(
              (note) => VoiceNoteTile(
                note: note,
              ),
            )
            .toList(),
      );
    });
  }

  Widget _voicesNotesList({required BuildContext context}) {
    return Obx(() {
      final error = controller.audioError.value;
      if (error == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          error.message(context),
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    });
  }
}
