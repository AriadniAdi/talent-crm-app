import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/home_banner.dart';
import '../../../../presentation/helpers/wrapper.dart';

void main() {
  testWidgets('HomeBanner renders title, subtitle and button', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          body: HomeBanner(
            title: 'Connect',
            subtitle: 'Explore talents',
            buttonText: 'View',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Connect'), findsOneWidget);
    expect(find.text('Explore talents'), findsOneWidget);
    expect(find.text('View'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('HomeBanner calls onPressed when button tapped', (tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      wrapper(
        Scaffold(
          body: HomeBanner(
            title: 'Title',
            subtitle: 'Subtitle',
            buttonText: 'Click',
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(pressed, isTrue);
  });

  testWidgets('HomeBanner contains CustomPaint background', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Scaffold(
          body: HomeBanner(
            title: 'Title',
            subtitle: 'Subtitle',
            buttonText: 'Click',
            onPressed: () {},
          ),
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
        Scaffold(
          body: HomeBanner(
            title: 'Title',
            subtitle: 'Subtitle',
            buttonText: 'Click',
            onPressed: () {},
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.byType(Container).first,
    );

    expect(container.constraints?.maxWidth ?? double.infinity,
        equals(double.infinity));
  });
}
