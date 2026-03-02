import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/core/widgets/error_state_widget.dart';
import '../../features/helpers/wrapper.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  group('ErrorStateWidget', () {
    const errorMessage = 'Ocorreu um erro inesperado';

    testWidgets('should render the error message correctly', (tester) async {
      await tester.pumpWidget(
        wrapper(
          ErrorStateWidget(
            message: errorMessage,
            onRetry: () {},
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should render the error icon with the correct size',
        (tester) async {
      await tester.pumpWidget(
        wrapper(
          ErrorStateWidget(
            message: errorMessage,
            onRetry: () {},
          ),
        ),
      );

      final iconFinder = find.byIcon(Icons.error_outline);
      expect(iconFinder, findsOneWidget);

      final Icon iconWidget = tester.widget(iconFinder);
      expect(iconWidget.size, 48);
    });

    testWidgets('should call onRetry callback when the button is tapped',
        (tester) async {
      bool wasRetryCalled = false;

      await tester.pumpWidget(
        wrapper(
          ErrorStateWidget(
            message: errorMessage,
            onRetry: () => wasRetryCalled = true,
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pump();

      expect(wasRetryCalled, isTrue);
    });

    testWidgets('should apply the correct padding (AppSpacing.lg)',
        (tester) async {
      await tester.pumpWidget(
        wrapper(
          ErrorStateWidget(
            message: errorMessage,
            onRetry: () {},
          ),
        ),
      );

      final paddingFinder = find.ancestor(
        of: find.byType(Column),
        matching: find.byType(Padding),
      );

      final Padding paddingWidget = tester.widget(paddingFinder.first);
      expect(paddingWidget.padding, const EdgeInsets.all(AppSpacing.lg));
    });
  });
}
