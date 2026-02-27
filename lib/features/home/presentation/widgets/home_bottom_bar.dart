import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/widgets/notification_icon_widget.dart';
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
                ? NotificationIcon(
                    count: notificationCount,
                    isActive: false,
                  )
                : Icon(item.icon),
            selectedIcon: isNotifications
                ? NotificationIcon(
                    count: notificationCount,
                    isActive: true,
                  )
                : Icon(item.activeIcon),
            label: item.label(context.translate),
          );
        }).toList());
  }
}
