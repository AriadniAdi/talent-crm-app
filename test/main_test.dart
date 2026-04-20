import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/main.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  setUp(() {
    Get.reset();
    final mockAuth = MockFirebaseAuth();
    final mockDb = MockFirebaseFirestore();
    final mockGoogle = MockGoogleSignIn();

    when(() => mockAuth.currentUser).thenReturn(null);
    when(() => mockAuth.authStateChanges())
        .thenAnswer((_) => const Stream.empty());

    Get.put<FirebaseAuth>(mockAuth);
    Get.put<FirebaseFirestore>(mockDb);
    Get.put<GoogleSignIn>(mockGoogle);
    Get.put<AppLocaleService>(AppLocaleService.inMemory(), permanent: true);
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
