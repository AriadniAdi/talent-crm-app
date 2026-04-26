import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/account/account_binding.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository authRepository;

  setUp(() {
    Get.reset();
    authRepository = MockAuthRepository();
    Get.put<AppLocaleService>(AppLocaleService.inMemory());
    Get.put<AuthRepository>(authRepository);

    when(() => authRepository.getUserProfile(uid: any(named: 'uid'))).thenAnswer(
      (_) async => Success(
        const UserModel(
          uid: '42',
          name: 'Test User',
          email: 'test@example.com',
        ),
      ),
    );
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
