import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:talent_crm_app/core/design/brand/talent_logo.dart';
import 'package:talent_crm_app/core/design/painters/network_painter.dart';

import '../../../features/helpers/wrapper.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });
  testWidgets('TalentLogo renders without crashing', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const TalentLogo(),
      ),
    );

    final finder = find.descendant(
      of: find.byType(TalentLogo),
      matching: find.byType(CustomPaint),
    );

    final customPaint = tester.widget<CustomPaint>(finder);

    expect(customPaint.painter, isA<NetworkPainter>());
  });

  testWidgets('TalentLogo respects size parameter', (tester) async {
    const size = 100.0;

    await tester.pumpWidget(
      wrapper(
        const TalentLogo(size: size),
      ),
    );

    final renderedSize = tester.getSize(find.byType(TalentLogo));

    expect(renderedSize.width, size);
    expect(renderedSize.height, size);
  });

  testWidgets('TalentLogo has correct dimensions', (tester) async {
    const size = 80.0;

    await tester.pumpWidget(
      wrapper(
        const TalentLogo(size: size),
      ),
    );

    final renderedSize = tester.getSize(find.byType(TalentLogo));

    expect(renderedSize.width, size);
    expect(renderedSize.height, size);
  });

  testWidgets('TalentLogo uses NetworkPainter', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const TalentLogo(),
      ),
    );

    final finder = find.descendant(
      of: find.byType(TalentLogo),
      matching: find.byType(CustomPaint),
    );

    final customPaint = tester.widget<CustomPaint>(finder);

    expect(customPaint.painter, isA<NetworkPainter>());
  });
}
