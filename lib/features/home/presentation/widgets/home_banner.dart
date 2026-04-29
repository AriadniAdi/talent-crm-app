import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/design.dart';

class HomeBanner extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final int totalTalents;

  const HomeBanner({
    super.key,
    required this.onSearchChanged,
    required this.totalTalents,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBanner(
      backgroundKey: const Key('home_banner_background'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar funcionário por nome ou cargo...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              '$totalTalents Talentos Cadastrados',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
