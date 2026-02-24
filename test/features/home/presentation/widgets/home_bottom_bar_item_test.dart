import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar_item.dart';

import 'package:talent_crm_app/l10n/app_localizations.dart';

import '../../../../presentation/helpers/wrapper.dart';

void main() {
  test('HomeTab enum contains expected values', () {
    expect(HomeTab.values.length, 4);
    expect(HomeTab.values, contains(HomeTab.home));
    expect(HomeTab.values, contains(HomeTab.teams));
    expect(HomeTab.values, contains(HomeTab.notifications));
    expect(HomeTab.values, contains(HomeTab.voiceNotes));
  });

  test('homeBottomBarItems has correct length and order', () {
    expect(homeBottomBarItems.length, 4);

    expect(homeBottomBarItems[0].tab, HomeTab.home);
    expect(homeBottomBarItems[1].tab, HomeTab.teams);
    expect(homeBottomBarItems[2].tab, HomeTab.notifications);
    expect(homeBottomBarItems[3].tab, HomeTab.voiceNotes);
  });

  test('homeBottomBarItems icons are correctly configured', () {
    expect(homeBottomBarItems[0].icon, Icons.home_outlined);
    expect(homeBottomBarItems[0].activeIcon, Icons.home);

    expect(homeBottomBarItems[1].icon, Icons.group_outlined);
    expect(homeBottomBarItems[1].activeIcon, Icons.group);

    expect(homeBottomBarItems[2].icon, Icons.notifications_outlined);
    expect(homeBottomBarItems[2].activeIcon, Icons.notifications);

    expect(homeBottomBarItems[3].icon, Icons.mic_none_outlined);
    expect(homeBottomBarItems[3].activeIcon, Icons.mic);
  });

  testWidgets('homeBottomBarItems labels resolve correctly from l10n',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;

            return Column(
              children: homeBottomBarItems
                  .map((item) => Text(item.label(l10n)))
                  .toList(),
            );
          },
        ),
      ),
    );

    expect(find.textContaining('Início'), findsOneWidget);
    expect(find.textContaining('Equipe'), findsOneWidget);
    expect(find.textContaining('Notifica'), findsOneWidget);
    expect(find.textContaining('Voz'), findsOneWidget);
  });
}
