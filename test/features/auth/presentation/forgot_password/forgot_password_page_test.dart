import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/presentation/forgot_password/forgot_password_controller.dart';
import 'package:talent_crm_app/features/auth/presentation/forgot_password/forgot_password_page.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

import '../../../helpers/wrapper.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
    required String? phone,
    required String? countryCode,
    required String? cpf,
    required DateTime? birthDate,
  }) async {
    return Success(true);
  }

  @override
  Future<Result<bool>> sendPasswordResetEmail({required String email}) async {
    return Success(true);
  }

  @override
  Future<Result<bool>> signIn({
    required String email,
    required String password,
  }) async {
    return Success(true);
  }

  @override
  Future<Result<bool>> signInWithGoogle() async {
    return Success(true);
  }

  @override
  Future<void> signOut() async {
    return;
  }

  @override
  Future<Result<void>> reloadUser() {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> sendEmailVerification() {
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> signInWithFacebook() {
    throw UnimplementedError();
  }
}

void main() {
  late ForgotPasswordController controller;

  setUp(() {
    Get.reset();
    controller = ForgotPasswordController(
      authRepository: _FakeAuthRepository(),
    );
    Get.put<ForgotPasswordController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('renders forgot password form', (tester) async {
    await tester.pumpWidget(
      wrapper(const ForgotPasswordPage()),
    );

    expect(find.text('Recuperar senha'), findsOneWidget);
    expect(find.text('Enviar e-mail de recuperação'), findsOneWidget);
    expect(find.text('Esqueci minha senha'), findsNothing);
  });

  testWidgets('renders success state when email was sent', (tester) async {
    controller.hasSentEmail.value = true;
    controller.submittedEmail.value = 'talent@example.com';

    await tester.pumpWidget(
      wrapper(const ForgotPasswordPage()),
    );

    await tester.pump();

    expect(find.text('Confira seu e-mail'), findsOneWidget);
    expect(find.text('Voltar para o login'), findsOneWidget);
    expect(find.text('Usar outro e-mail'), findsOneWidget);
  });
}
