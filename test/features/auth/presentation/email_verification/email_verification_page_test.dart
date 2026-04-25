import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/presentation/email_verification/email_verification_controller.dart';
import 'package:talent_crm_app/features/auth/presentation/email_verification/email_verification_page.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

import '../../../helpers/wrapper.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late EmailVerificationController controller;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    when(() => mockAuthRepository.reloadUser())
        .thenAnswer((_) async => Success(null));

    controller = EmailVerificationController(mockAuthRepository);
    Get.put<EmailVerificationController>(controller);
  });

  tearDown(() {
    Get.delete<EmailVerificationController>();
  });

  testWidgets('should render all components', (tester) async {
    await tester.pumpWidget(wrapper(const EmailVerificationPage()));

    expect(find.text('Verificação de E-mail'), findsOneWidget);
    expect(find.text('Confirme seu e-mail'), findsOneWidget);
    expect(find.byIcon(Icons.mark_email_read_outlined), findsOneWidget);
    expect(find.text('Reenviar e-mail de confirmação'), findsOneWidget);
    expect(find.text('Voltar para o login'), findsOneWidget);
  });

  testWidgets('should call resendVerificationEmail when button pressed', (tester) async {
    when(() => mockAuthRepository.sendEmailVerification())
        .thenAnswer((_) async => Success(null));

    await tester.pumpWidget(wrapper(const EmailVerificationPage()));

    await tester.tap(find.text('Reenviar e-mail de confirmação'));
    await tester.pump();

    verify(() => mockAuthRepository.sendEmailVerification()).called(1);
  });

  testWidgets('should call signOut when back to login pressed', (tester) async {
    when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});

    await tester.pumpWidget(wrapper(const EmailVerificationPage()));

    await tester.tap(find.text('Voltar para o login'));
    await tester.pump();

    verify(() => mockAuthRepository.signOut()).called(1);
  });
}
