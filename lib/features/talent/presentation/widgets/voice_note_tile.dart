import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';

class VoiceNoteTile extends GetView<TalentController> {
  final VoiceNoteModel note;

  const VoiceNoteTile({super.key, required this.note});

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
                Text(
                  note.durationFormatted,
                  style: theme.textTheme.bodyMedium,
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
