import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/formatters/format_internacional_phone.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class InfoCard extends StatelessWidget {
  final Talent talent;

  const InfoCard({super.key, required this.talent});

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
          _infoRow(context, Icons.location_on, talent.city),
          _divider(),
          _infoRow(context, Icons.business, talent.company),
          _divider(),
          _infoRow(context, Icons.language, talent.website),
          _divider(),
          _infoRow(context, Icons.email, talent.contact.email),
          _divider(),
          _infoRow(context, Icons.phone,
              formatInternationalPhone(talent.contact.phone)),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, IconData icon, String value) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          IconButton(
            tooltip: context.translate.copy,
            icon: Icon(
              Icons.copy_rounded,
              size: 18,
              color: theme.primary,
            ),
            onPressed: () => _copyToClipboard(context, value),
          ),
          Icon(
            icon,
            size: 22,
            color: theme.primary,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.translate.copiedToClipboard),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _divider() => const Divider(height: 1);
}
