import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/voice/entities/voice_note.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';

class VoiceNoteTile extends StatelessWidget {
  final VoiceNote note;
  final String talentId;

  const VoiceNoteTile({super.key, required this.note, required this.talentId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final VoiceController controller = Get.find<VoiceController>(tag: talentId);

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
