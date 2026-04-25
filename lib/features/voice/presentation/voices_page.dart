import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/features/voice/entities/voice_note.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class VoicesPage extends GetView<VoiceController> {
  const VoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BasePage(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () {
          final notes = controller.voiceNotes;

          if (notes.isEmpty) {
            return Center(
              child: Text(
                context.translate.noVoicesRegistered,
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return _VoiceNoteListItem(note: note);
            },
          );
        },
      ),
    );
  }
}

class _VoiceNoteListItem extends GetView<VoiceController> {
  final VoiceNote note;

  const _VoiceNoteListItem({required this.note});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Obx(() {
      final isPlaying = controller.isPlayingId.value == note.id;

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          IconButton(
            onPressed: () => controller.togglePlay(note),
            icon: Icon(
              isPlaying ? Icons.stop : Icons.play_arrow,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.talentId != null)
                  Text(
                    context.translate.talentIdLabel(note.talentId!),
                    style: theme.textTheme.labelSmall?.copyWith(color: colors.primary),
                  ),
                Text(
                  context.translate.recordingLabel(note.id.substring(0, 8)),
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatDate(note.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.deleteNote(note.id),
            icon: const Icon(Icons.delete_outline),
          )
        ]),
      );
    });
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
