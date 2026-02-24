import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/widgets/base_page.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';

import '../../../core/design/design.dart';

class TalentPage extends StatelessWidget {
  final Talent talent;
  final List<VoiceNoteModel> voiceNotes;
  final VoidCallback onRecord;

  const TalentPage({
    super.key,
    required this.talent,
    required this.voiceNotes,
    required this.onRecord,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BasePage(
      title: Text(talent.name),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: AppSpacing.xl,
              backgroundImage: NetworkImage(talent.avatarUrl),
            ),
            const SizedBox(height: 24),
            Text(
              talent.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              talent.description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            _InfoCard(talent: talent),
            const SizedBox(height: 32),
            _ObservationsSection(
              voiceNotes: voiceNotes,
              onRecord: onRecord,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Talent talent;

  const _InfoCard({required this.talent});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withValues(alpha: 0.05),
          )
        ],
      ),
      child: Column(
        children: [
          _infoRow(Icons.location_on, talent.city),
          _divider(),
          _infoRow(Icons.business, talent.company),
          _divider(),
          _infoRow(Icons.language, talent.website),
          _divider(),
          _infoRow(Icons.email, talent.contact.email),
          _divider(),
          _infoRow(Icons.phone, talent.contact.phone),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: AppSpacing.lg),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1);
}

class _ObservationsSection extends StatelessWidget {
  final List<VoiceNoteModel> voiceNotes;
  final VoidCallback onRecord;

  const _ObservationsSection({
    required this.voiceNotes,
    required this.onRecord,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Observações",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _ObservationInput(),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onRecord,
          icon: const Icon(Icons.mic),
          label: const Text("Gravar Observação"),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (voiceNotes.isEmpty)
          Text(
            "Nenhuma gravação ainda",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          )
        else
          ...voiceNotes.map(
            (note) => _VoiceNoteTile(note: note),
          ),
      ],
    );
  }
}

class _VoiceNoteTile extends StatelessWidget {
  final VoiceNoteModel note;

  const _VoiceNoteTile({required this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.play_arrow),
      ),
      title: Text("Nota • ${note.durationFormatted}"),
      subtitle: Text(_formatDate(note.createdAt)),
      onTap: () {
        // TODO: play audio
      },
    );
  }

  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min atrás";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h atrás";
    } else {
      return "${difference.inDays} dias atrás";
    }
  }
}

class _ObservationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      decoration: InputDecoration(
        hintText: "Deixe uma observação sobre o candidato...",
        prefixIcon: const Icon(Icons.edit),
        filled: true,
        fillColor: colors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
