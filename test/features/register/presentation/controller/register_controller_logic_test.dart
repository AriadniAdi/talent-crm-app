import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_contract.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';

import 'package:get/get.dart';

class MockRegisterUseCase extends Mock implements RegisterContract {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterUseCase mockUseCase;
  late RegisterController controller;

  setUpAll(() {
    Get.testMode = true;
    registerFallbackValue(const RegisterParams(
      name: '',
      email: '',
      password: '',
      confirmPassword: '',
      phone: '',
      countryCode: '',
      cpf: '',
      birthDate: null,
    ));
  });

  setUp(() {
    mockUseCase = MockRegisterUseCase();
    controller = RegisterController(mockUseCase);
  });

  group('RegisterController Logic', () {
    test('register should not call useCase if name is empty', () async {
      controller.fullNameController.text = '';
      controller.emailController.text = 'test@test.com';
      controller.passwordController.text = '123456';
      controller.confirmPasswordController.text = '123456';
      controller.cpfController.text = '12345678900';
      controller.birthDateController.text = '01/01/1990';
      controller.phoneController.text = '1234567890';

      await controller.register();

      verifyNever(() => mockUseCase(any()));
      expect(
          controller.validationErrors
              .any((e) => e is ValidationError && e.field == FieldType.name),
          isTrue);
    });

    test('register should call useCase when all fields are valid', () async {
      controller.fullNameController.text = 'João Silva';
      controller.emailController.text = 'joao@silva.com';
      controller.passwordController.text = '123456';
      controller.confirmPasswordController.text = '123456';
      controller.cpfController.text =
          '52998224725'; // Valid-ish CPF for the internal logic
      controller.birthDateController.text = '01/01/1990';
      controller.phoneController.text = '11988887777';

      when(() => mockUseCase(any())).thenAnswer((_) async => {});

      await controller.register();

      verify(() => mockUseCase(any())).called(1);
      expect(controller.validationErrors.isEmpty, isTrue);
      expect(controller.isLoading.value, isFalse);
    });

    test('onBirthDateChanged sets error for future date', () {
      const futureDate = '01/01/2099';
      controller.onBirthDateChanged(futureDate);

      expect(controller.hasError(FieldType.birthDate), isTrue);
    });

    test('onCpfChanged sets error for invalid CPF', () {
      controller.onCpfChanged('11111111111'); // Invalid CPF (same digits)

      expect(controller.hasError(FieldType.cpf), isTrue);
    });

    test('onEmailChanged sets error for invalid email', () {
      controller.onEmailChanged('invalid-email');

      expect(controller.hasError(FieldType.email), isTrue);
    });
  });
}
