import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/design/animations/fade_slide.dart';

import '../../../presentation/helpers/wrapper.dart';

void main() {
  testWidgets('renders child correctly', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const FadeSlide(
          child: Text('Animated'),
        ),
        surfaceSize: const Size(300, 200),
      ),
    );

    expect(find.text('Animated'), findsOneWidget);
  });

  testWidgets('starts fully transparent', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const FadeSlide(
          child: Text('Animated'),
        ),
        surfaceSize: const Size(300, 200),
      ),
    );

    final opacity = tester.widget<Opacity>(find.byType(Opacity)).opacity;

    expect(opacity, 0);
  });

  testWidgets('animates to full opacity after duration', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const FadeSlide(
          child: Text('Animated'),
        ),
        surfaceSize: const Size(300, 200),
      ),
    );

    await tester.pump(const Duration(milliseconds: 800));

    final opacity = tester.widget<Opacity>(find.byType(Opacity)).opacity;

    expect(opacity, 1);
  });

  testWidgets('applies vertical translation during animation', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const FadeSlide(
          child: Text('Animated'),
        ),
        surfaceSize: const Size(300, 200),
      ),
    );

    final transformBefore =
        tester.widget<Transform>(find.byType(Transform)).transform;

    await tester.pump(const Duration(milliseconds: 400));

    final transformMid =
        tester.widget<Transform>(find.byType(Transform)).transform;

    expect(transformBefore, isNot(equals(transformMid)));
  });
}
