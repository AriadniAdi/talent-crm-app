import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/voice_note_tile.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';
import 'package:talent_crm_app/l10n/translate.dart';

import '../../../../core/design/design.dart';

class ObservationsSection extends StatelessWidget {
  final String talentId;
  const ObservationsSection({super.key, required this.talentId});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final ThemeData theme = Theme.of(context);
    final VoiceController controller = Get.find<VoiceController>(tag: talentId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(
            theme: theme, colors: colors, text: context.translate.observations),
        const SizedBox(height: AppSpacing.lg),
        _recordingButton(controller),
        const SizedBox(height: AppSpacing.xl),
        _voiceNotesList(context, controller, theme: theme, colors: colors),
        const SizedBox(height: AppSpacing.md),
        _errorMessage(context, controller),
      ],
    );
  }

  Widget _header({
    required ThemeData theme,
    required ColorScheme colors,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.xl),
          Icon(Icons.notes, color: colors.primary),
          const SizedBox(width: AppSpacing.md),
          Text(text, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _recordingButton(VoiceController controller) {
    return SizedBox(
      width: double.infinity,
      child: Builder(builder: (context) {
        return Obx(() {
          return ElevatedButton.icon(
            onPressed: controller.toggleRecording,
            icon: Icon(
              controller.isRecording.value ? Icons.stop : Icons.mic,
            ),
            label: Text(
              controller.isRecording.value
                  ? context.translate.stopRecording
                  : context.translate.recordObservation,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );
        });
      }),
    );
  }

  Widget _voiceNotesList(BuildContext context, VoiceController controller, {required ThemeData theme, required ColorScheme colors}) {
    return Obx(
      () {
        final notes = controller.voiceNotes;
        if (notes.isEmpty) {
          return Text(
            context.translate.noRecordingsYet,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          );
        }

        return Column(
          children: notes
              .map(
                (note) => VoiceNoteTile(
                  note: note,
                  talentId: talentId,
                ),
              )
              .toList(),
        );
      }
    );
  }

  Widget _errorMessage(BuildContext context, VoiceController controller) {
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
