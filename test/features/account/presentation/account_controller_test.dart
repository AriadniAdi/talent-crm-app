import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/auth_manager.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/repositories/user_repository.dart';
import 'package:get/get.dart';

class MockUserRepository extends Mock implements UserRepository {}
class TestAuthManager extends GetxController implements AuthManager {
  @override
  Rx<User?> user = Rx<User?>(null);

  @override
  bool get isAuthenticated => false;

  @override
  Future<void> signOut() async {}
}

void main() {
  late AppLocaleService localeService;
  late MockUserRepository userRepository;
  late TestAuthManager authManager;

  setUp(() {
    localeService = AppLocaleService.inMemory();
    userRepository = MockUserRepository();
    authManager = TestAuthManager();
  });

  group('AccountController', () {
    test('changeLocale updates current locale', () async {
      final controller = AccountController(
        localeService: localeService,
        userRepository: userRepository,
        authManager: authManager,
      );

      await controller.changeLocale(const Locale('es'));

      expect(controller.currentLocale.value, const Locale('es'));
    });
  });
}
