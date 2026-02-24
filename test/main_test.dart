import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:talent_crm_app/main.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('MyApp builds GetMaterialApp', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(GetMaterialApp), findsOneWidget);
  });

  testWidgets('Initial route is splash', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final app = tester.widget<GetMaterialApp>(
      find.byType(GetMaterialApp),
    );

    expect(app.initialRoute, AppRoutes.splash);
  });

  testWidgets('Locale is Portuguese', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final app = tester.widget<GetMaterialApp>(
      find.byType(GetMaterialApp),
    );

    expect(app.locale, const Locale('pt'));
  });

  testWidgets('Localization delegates include AppLocalizations',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final app = tester.widget<GetMaterialApp>(
      find.byType(GetMaterialApp),
    );

    expect(
      app.localizationsDelegates,
      contains(AppLocalizations.delegate),
    );
  });

  testWidgets('Debug banner is disabled', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final app = tester.widget<GetMaterialApp>(
      find.byType(GetMaterialApp),
    );

    expect(app.debugShowCheckedModeBanner, false);
  });
}
