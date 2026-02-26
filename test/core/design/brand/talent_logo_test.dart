import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/design/brand/talent_logo.dart';
import 'package:talent_crm_app/core/design/painters/network_painter.dart';

import '../../../presentation/helpers/wrapper.dart';

void main() {
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

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(TalentLogo),
        matching: find.byType(Container),
      ),
    );

    expect(container.constraints?.maxWidth ?? size, size);
  });

  testWidgets('TalentLogo has correct dimensions', (tester) async {
    const size = 80.0;

    await tester.pumpWidget(
      wrapper(
        const TalentLogo(size: size),
      ),
    );

    final logoFinder = find.byType(TalentLogo);
    final sizeRendered = tester.getSize(logoFinder);

    expect(sizeRendered.width, size);
    expect(sizeRendered.height, size);
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
