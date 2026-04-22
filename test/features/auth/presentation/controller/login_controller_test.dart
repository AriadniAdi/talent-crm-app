import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/presentation/controller/login_controller.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository authRepository;
  late LoginController controller;

  setUp(() {
    Get.testMode = true;
    Get.reset();
    authRepository = MockAuthRepository();
    controller = LoginController(authRepository: authRepository);
  });

  tearDown(Get.reset);

  group('LoginController', () {
    test('continueWithGoogle delegates sign in and resets loading on success',
        () async {
      when(() => authRepository.signInWithGoogle())
          .thenAnswer((_) async => Success(true));

      await controller.continueWithGoogle();

      expect(controller.isLoading.value, isFalse);
      verify(() => authRepository.signInWithGoogle()).called(1);
    });

    test('continueWithGoogle does not run twice while loading', () async {
      controller.isLoading.value = true;

      await controller.continueWithGoogle();

      verifyNever(() => authRepository.signInWithGoogle());
    });

    test('continueWithFacebook delegates sign in and resets loading', () async {
      when(() => authRepository.signInWithFacebook())
          .thenAnswer((_) async => Success(true));

      await controller.continueWithFacebook();

      expect(controller.isLoading.value, isFalse);
      verify(() => authRepository.signInWithFacebook()).called(1);
    });
  });
}
