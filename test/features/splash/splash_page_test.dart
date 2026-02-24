import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:talent_crm_app/features/splash/splash_page.dart';
import 'package:talent_crm_app/core/design/brand/talent_logo.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  testWidgets('SplashPage renders logo and title', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: SplashPage(),
      ),
    );

    expect(find.byType(TalentLogo), findsOneWidget);
    expect(find.byType(FadeTransition), findsOneWidget);
  });

  testWidgets('SplashPage navigates to home after 2 seconds', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashPage(),
          ),
          GetPage(
            name: '/home',
            page: () => const Scaffold(body: Text('Home Page')),
          ),
        ],
      ),
    );

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Home Page'), findsOneWidget);
  });
}
