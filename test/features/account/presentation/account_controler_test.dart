import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';

class TestAccountController extends AccountController {
  bool loadCalled = false;

  TestAccountController(super.id);
}

void main() {
  group('AccountController', () {
    test('id is assigned correctly', () {
      final controller = AccountController('123');

      expect(controller.id, '123');
    });
  });
}
