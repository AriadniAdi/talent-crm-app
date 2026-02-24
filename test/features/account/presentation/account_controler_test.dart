import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/account/presentation/account_controler.dart';

class TestAccountController extends AccountController {
  bool loadCalled = false;

  TestAccountController(super.id);

  @override
  void loadTalent() {
    loadCalled = true;
  }
}

void main() {
  group('AccountController', () {
    test('id is assigned correctly', () {
      final controller = AccountController('123');

      expect(controller.id, '123');
    });

    test('onInit calls loadTalent', () {
      final controller = TestAccountController('123');

      controller.onInit();

      expect(controller.loadCalled, true);
    });
  });
}
