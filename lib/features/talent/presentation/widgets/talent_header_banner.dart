import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/app_banner.dart';

class TalentHeaderBanner extends StatelessWidget {
  final String avatarUrl;
  final String title;
  final String subtitle;

  const TalentHeaderBanner({
    super.key,
    required this.avatarUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBanner(
      backgroundKey: const Key('profile_banner_background'),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              buildShadowAvatar(
                context: context,
                avatarUrl: avatarUrl,
                radius: 28,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: (theme.textTheme.bodyMedium ?? const TextStyle()).copyWith(
              color: Colors.white.withValues(alpha: 0.95),
              fontWeight: FontWeight.w600,
              height: 1.15,
              letterSpacing: 0.2,
              shadows: const [
                Shadow(
                  blurRadius: 10,
                  offset: Offset(0, 2),
                  color: Colors.black26,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

Widget buildShadowAvatar({
  required BuildContext context,
  required String avatarUrl,
  double radius = 28,
}) {
  final colors = Theme.of(context).colorScheme;

  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: colors.primary.withValues(alpha: 0.25),
          blurRadius: 22,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.surface.withValues(alpha: 0.45),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: colors.surface.withValues(alpha: 0.25),
        backgroundImage: NetworkImage(avatarUrl),
      ),
    ),
  );
}
