import 'package:talent_crm_app/core/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/core/design/app_text_styles.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  final bool isActive;

  const NotificationIcon({
    super.key,
    required this.count,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(isActive ? Icons.notifications : Icons.notifications_outlined),
        if (count > 0)
          Positioned(
            right: -AppSpacing.sm,
            top: -AppSpacing.xs,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: const BoxDecoration(
                color: AppColors.badge,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                count > 9 ? '9+' : '$count',
                style: AppTextStyles.badge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
