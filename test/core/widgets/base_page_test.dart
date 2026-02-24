import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/widgets/base_page.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  Widget buildTestWidget(Widget child) {
    return GetMaterialApp(
      home: child,
    );
  }

  group('BasePage', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            title: Text('Title'),
            child: Text('Body'),
          ),
        ),
      );

      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('shows AppBar when showAppBar is true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            title: Text('Title'),
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('hides AppBar when showAppBar is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            showAppBar: false,
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('shows back button when enabled', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            title: Text('Title'),
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('hides back button when disabled', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            showBackButton: false,
            title: Text('Title'),
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);
    });

    testWidgets('applies default padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            child: Text('Body'),
          ),
        ),
      );

      final paddingFinder = find.ancestor(
        of: find.text('Body'),
        matching: find.byType(Padding),
      );

      final paddingWidget = tester.widget<Padding>(paddingFinder.first);

      expect(
        paddingWidget.padding,
        const EdgeInsets.all(AppSpacing.lg),
      );
    });

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(50);

      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            padding: customPadding,
            child: Text('Body'),
          ),
        ),
      );

      final paddingFinder = find.ancestor(
        of: find.text('Body'),
        matching: find.byType(Padding),
      );

      final paddingWidget = tester.widget<Padding>(paddingFinder.first);

      expect(paddingWidget.padding, customPadding);
    });

    testWidgets('renders bottomNavigationBar', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            // ignore: sort_child_properties_last
            child: SizedBox(),
            bottomNavigationBar: Text('Bottom'),
          ),
        ),
      );

      expect(find.text('Bottom'), findsOneWidget);
    });

    testWidgets('renders actions in AppBar', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BasePage(
            title: Text('Title'),
            actions: [Icon(Icons.add)],
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
