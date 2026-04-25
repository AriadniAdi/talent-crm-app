import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/features/auth/presentation/email_verification/email_verification_controller.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late EmailVerificationController controller;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();

    // Stubbing reloadUser to avoid infinite polling issues in tests if not careful
    when(() => mockAuthRepository.reloadUser())
        .thenAnswer((_) async => Success(null));

    controller = EmailVerificationController(mockAuthRepository);
  });

  tearDown(() {
    controller.onClose();
  });

  group('EmailVerificationController', () {
    test('resendVerificationEmail success', () async {
      when(() => mockAuthRepository.sendEmailVerification())
          .thenAnswer((_) async => Success(null));

      await controller.resendVerificationEmail();

      verify(() => mockAuthRepository.sendEmailVerification()).called(1);
      expect(controller.error.value, isNull);
    });

    test('resendVerificationEmail failure', () async {
      final appError = AuthError('Error', AuthErrorCode.authenticationFailed);
      when(() => mockAuthRepository.sendEmailVerification())
          .thenAnswer((_) async => Failure(appError));

      await controller.resendVerificationEmail();

      verify(() => mockAuthRepository.sendEmailVerification()).called(1);
      expect(controller.error.value, appError);
    });

    test('signOut calls repository signOut', () async {
      when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});

      await controller.signOut();

      verify(() => mockAuthRepository.signOut()).called(1);
    });
  });
}
