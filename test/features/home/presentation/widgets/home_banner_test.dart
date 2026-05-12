import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/home_banner.dart';
import '../../../helpers/wrapper.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });
  testWidgets('HomeBanner renders search field and talent count', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          body: HomeBanner(
            onSearchChanged: (v) {},
            totalTalents: 38,
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('38 Talentos Cadastrados'), findsOneWidget);
  });

  testWidgets('HomeBanner calls onSearchChanged when typing', (tester) async {
    String? searchValue;

    await tester.pumpWidget(
      wrapper(
        HomeBanner(
          onSearchChanged: (v) {
            searchValue = v;
          },
          totalTalents: 0,
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'John');
    await tester.pump();

    expect(searchValue, 'John');
  });

  testWidgets('HomeBanner contains CustomPaint background', (tester) async {
    await tester.pumpWidget(
      wrapper(
        HomeBanner(
          onSearchChanged: (v) {},
          totalTalents: 0,
        ),
      ),
    );

    expect(
      find.byKey(const Key('home_banner_background')),
      findsOneWidget,
    );
  });

  testWidgets('HomeBanner expands full width', (tester) async {
    await tester.pumpWidget(
      wrapper(
        HomeBanner(
          onSearchChanged: (v) {},
          totalTalents: 0,
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(HomeBanner),
        matching: find.byType(Container),
      ).first,
    );

    expect(container.constraints?.maxWidth ?? double.infinity,
        equals(double.infinity));
  });
}
