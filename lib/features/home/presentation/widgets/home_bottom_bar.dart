import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar_item.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class HomeBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int notificationCount;

  const HomeBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        elevation: AppBottomBarStyle.elevation,
        backgroundColor: AppBottomBarStyle.backgroundColor,
        destinations: homeBottomBarItems.map((item) {
          final isNotifications = item.tab == HomeTab.notifications;

          return NavigationDestination(
            icon: isNotifications
                ? _NotificationIcon(
                    count: notificationCount,
                    isActive: false,
                  )
                : Icon(item.icon),
            selectedIcon: isNotifications
                ? _NotificationIcon(
                    count: notificationCount,
                    isActive: true,
                  )
                : Icon(item.activeIcon),
            label: item.label(context.translate),
          );
        }).toList());
  }
}

class _NotificationIcon extends StatelessWidget {
  final int count;
  final bool isActive;

  const _NotificationIcon({
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
