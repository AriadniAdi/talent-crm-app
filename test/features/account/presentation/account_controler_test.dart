import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';

void main() {
  late AppLocaleService localeService;

  setUp(() {
    localeService = AppLocaleService.inMemory();
  });

  group('AccountController', () {
    test('id is assigned correctly', () {
      final controller = AccountController(
        '123',
        localeService: localeService,
      );

      expect(controller.id, '123');
    });

    test('changeLocale updates current locale', () async {
      final controller = AccountController(
        '123',
        localeService: localeService,
      );

      await controller.changeLocale(const Locale('es'));

      expect(controller.currentLocale.value, const Locale('es'));
    });
  });
}
