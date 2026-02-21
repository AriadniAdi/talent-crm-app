import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      elevation: AppBottomBarStyle.elevation,
      backgroundColor: AppBottomBarStyle.backgroundColor,
      selectedItemColor: AppBottomBarStyle.selectedColor,
      unselectedItemColor: AppBottomBarStyle.unselectedColor,
      selectedLabelStyle: AppBottomBarStyle.selectedLabelStyle,
      unselectedLabelStyle: AppBottomBarStyle.unselectedLabelStyle,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group_outlined),
          activeIcon: const Icon(Icons.group),
          label: AppLocalizations.of(context)!.teams,
        ),
        BottomNavigationBarItem(
          icon: _NotificationIcon(
            count: notificationCount,
            isActive: false,
          ),
          activeIcon: _NotificationIcon(
            count: notificationCount,
            isActive: true,
          ),
          label: AppLocalizations.of(context)!.notifications,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.mic_none_outlined),
          activeIcon: const Icon(Icons.mic),
          label: AppLocalizations.of(context)!.voiceNotes,
        ),
      ],
    );
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
        Icon(
          isActive ? Icons.notifications : Icons.notifications_outlined,
        ),
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
