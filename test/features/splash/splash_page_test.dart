import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:talent_crm_app/features/splash/splash_page.dart';
import 'package:talent_crm_app/core/design/brand/talent_logo.dart';
import 'package:talent_crm_app/l10n/translate.dart';

import '../helpers/wrapper.dart';

class FakeAppLinks extends Fake implements AppLinks {
  @override
  Future<Uri?> getInitialAppLink() async => null;
}

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });
  testWidgets('SplashPage renders logo and title', (tester) async {
    await tester.pumpWidget(
      wrapper(
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
      wrapper(
        SplashPage(
          delay: Duration.zero,
          enableNavigation: true,
          appLinks: FakeAppLinks(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('Home')), findsOneWidget);
  });
}
