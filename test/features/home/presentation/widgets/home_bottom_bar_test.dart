import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar.dart';

import '../../../../presentation/helpers/wrapper.dart';

void main() {
  testWidgets('HomeBottomBar renders 4 destinations', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          bottomNavigationBar: HomeBottomBar(
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ),
    );

    expect(find.byType(NavigationDestination), findsNWidgets(4));
  });

  testWidgets('HomeBottomBar uses correct selectedIndex', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          bottomNavigationBar: HomeBottomBar(
            currentIndex: 2,
            onTap: (_) {},
          ),
        ),
      ),
    );

    final navBar = tester.widget<NavigationBar>(
      find.byType(NavigationBar),
    );

    expect(navBar.selectedIndex, 2);
  });

  testWidgets('HomeBottomBar calls onTap when destination tapped',
      (tester) async {
    int? tappedIndex;

    await tester.pumpWidget(
      wrapper(
        Scaffold(
          bottomNavigationBar: HomeBottomBar(
            currentIndex: 0,
            onTap: (index) {
              tappedIndex = index;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(NavigationDestination).at(1));
    await tester.pump();

    expect(tappedIndex, 1);
  });

  testWidgets('Notification badge appears when count > 0', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          bottomNavigationBar: HomeBottomBar(
            currentIndex: 0,
            onTap: (_) {},
            notificationCount: 3,
          ),
        ),
      ),
    );

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Notification badge shows 9+ when count > 9', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          bottomNavigationBar: HomeBottomBar(
            currentIndex: 0,
            onTap: (_) {},
            notificationCount: 15,
          ),
        ),
      ),
    );

    expect(find.text('9+'), findsOneWidget);
  });

  testWidgets('Notification badge does not appear when count = 0',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          bottomNavigationBar: HomeBottomBar(
            currentIndex: 0,
            onTap: (_) {},
            notificationCount: 0,
          ),
        ),
      ),
    );

    expect(find.text('0'), findsNothing);
  });
}
