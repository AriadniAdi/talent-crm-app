import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';

import '../../helpers/wrapper.dart';

void main() {
  late AccountController controller;

  setUp(() {
    Get.reset();
    Get.testMode = true;

    final localeService = AppLocaleService.inMemory();
    Get.put<AppLocaleService>(localeService);

    controller = AccountController(
      '1',
      localeService: localeService,
    );

    Get.put<AccountController>(controller);
  });

  tearDown(Get.reset);

  testWidgets('AccountPage renders with language selector', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );

    expect(find.byKey(const Key('account-page')), findsOneWidget);
    expect(find.byKey(const Key('language-selector-tile')), findsOneWidget);
    expect(find.text('Idioma'), findsOneWidget);
    expect(find.text('Português'), findsOneWidget);
  });

  testWidgets('AccountPage updates locale when a language is selected',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );

    await tester.tap(find.byKey(const Key('language-selector-tile')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-option-en')));
    await tester.pumpAndSettle();

    expect(controller.currentLocale.value, const Locale('en'));
    expect(find.text('English'), findsOneWidget);
  });
}
