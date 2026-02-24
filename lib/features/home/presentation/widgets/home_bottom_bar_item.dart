import 'package:flutter/material.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

enum HomeTab { home, teams, notifications, voiceNotes }

class HomeBottomBarItemConfig {
  final HomeTab tab;
  final IconData icon;
  final IconData activeIcon;
  final String Function(AppLocalizations l10n) label;

  const HomeBottomBarItemConfig({
    required this.tab,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

final homeBottomBarItems = <HomeBottomBarItemConfig>[
  HomeBottomBarItemConfig(
    tab: HomeTab.home,
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    label: (l10n) => l10n.home,
  ),
  HomeBottomBarItemConfig(
    tab: HomeTab.teams,
    icon: Icons.group_outlined,
    activeIcon: Icons.group,
    label: (l10n) => l10n.teams,
  ),
  HomeBottomBarItemConfig(
    tab: HomeTab.notifications,
    icon: Icons.notifications_outlined,
    activeIcon: Icons.notifications,
    label: (l10n) => l10n.notifications,
  ),
  HomeBottomBarItemConfig(
    tab: HomeTab.voiceNotes,
    icon: Icons.mic_none_outlined,
    activeIcon: Icons.mic,
    label: (l10n) => l10n.voiceNotes,
  ),
];
