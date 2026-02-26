import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/design/app_banner.dart';

import '../../presentation/helpers/wrapper.dart';

void main() {
  group('AppBanner Widget', () {
    testWidgets('deve renderizar o child corretamente',
        (WidgetTester tester) async {
      const testText = 'Banner Content';

      await tester.pumpWidget(
        wrapper(
          const AppBanner(
            child: Text(testText),
          ),
        ),
      );

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('deve aplicar padding padrão', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapper(
          const AppBanner(
            child: Text('Test'),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);

      expect(container.padding, const EdgeInsets.all(20));
    });

    testWidgets('deve posicionar o CustomPaint como background',
        (tester) async {
      const bgKey = Key('banner_background');

      await tester.pumpWidget(
        wrapper(
          const AppBanner(
            backgroundKey: bgKey,
            child: Text('Test'),
          ),
        ),
      );

      final positioned = find.ancestor(
        of: find.byKey(bgKey),
        matching: find.byType(Positioned),
      );

      expect(positioned, findsOneWidget);
    });

    testWidgets('deve posicionar o CustomPaint como background',
        (tester) async {
      const bgKey = Key('banner_background');

      await tester.pumpWidget(
        wrapper(
          const AppBanner(
            backgroundKey: bgKey,
            child: Text('Test'),
          ),
        ),
      );

      final positioned = find.ancestor(
        of: find.byKey(bgKey),
        matching: find.byType(Positioned),
      );

      expect(positioned, findsOneWidget);
    });

    testWidgets('deve aplicar gradiente e sombra na decoração',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapper(
          const AppBanner(
            child: Text('Test'),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);

      final decoration = container.decoration as BoxDecoration;

      expect(decoration.gradient, isA<LinearGradient>());
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.isNotEmpty, true);
    });
  });
}
