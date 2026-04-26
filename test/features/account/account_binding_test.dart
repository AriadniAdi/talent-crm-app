import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/features/account/account_binding.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.put<AppLocaleService>(AppLocaleService.inMemory());
  });

  group('AccountBinding', () {
    test('registers AccountController with id from parameters', () {
      Get.parameters = {'id': '42'};

      final binding = AccountBinding();
      binding.dependencies();

      expect(Get.isRegistered<AccountController>(), true);

      final controller = Get.find<AccountController>();

      expect(controller.id, '42');
    });

    test('lazyPut creates instance only when accessed', () {
      Get.parameters = {'id': '99'};

      final binding = AccountBinding();
      binding.dependencies();

      expect(Get.isRegistered<AccountController>(), true);

      final controller = Get.find<AccountController>();

      expect(controller.id, '99');
    });
  });
}
