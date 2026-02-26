import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/splash/splash_page.dart';
import 'package:talent_crm_app/core/design/brand/talent_logo.dart';
import 'package:talent_crm_app/l10n/translate.dart';

import 'splash_wrapper.dart';

void main() {
  testWidgets('SplashPage renders logo and title', (tester) async {
    await tester.pumpWidget(
      splashWrapper(
        const SplashPage(
          delay: Duration.zero,
          enableNavigation: false,
        ),
      ),
    );

    expect(find.byType(TalentLogo), findsOneWidget);

    final context = tester.element(find.byType(SplashPage));
    final expectedTitle = context.translate.appTitle;

    expect(find.text(expectedTitle), findsOneWidget);
  });

  testWidgets('SplashPage navigates to home', (tester) async {
    await tester.pumpWidget(
      splashWrapper(
        const SplashPage(delay: Duration.zero),
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashPage(delay: Duration.zero),
          ),
          GetPage(
            name: '/home',
            page: () => const Scaffold(body: Text('Home Page')),
          ),
        ],
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Home Page'), findsOneWidget);
  });

  testWidgets('SplashPage navigates to home', (tester) async {
    await tester.pumpWidget(
      splashWrapper(
        const SplashPage(
          delay: Duration.zero,
          enableNavigation: true,
        ),
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashPage(
              delay: Duration.zero,
            ),
          ),
          GetPage(
            name: AppRoutes.home,
            page: () => const Scaffold(body: Text('Home Page')),
          ),
        ],
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Home Page'), findsOneWidget);
  });
}
