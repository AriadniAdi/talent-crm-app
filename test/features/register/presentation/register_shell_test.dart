import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_contract.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';

import 'package:talent_crm_app/features/register/presentation/register_shell.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';

import '../../helpers/wrapper.dart';

class MockRegisterContract extends Mock implements RegisterContract {}

void main() {
  late RegisterController controller;
  late RegisterContract usecase;

  setUp(() {
    Get.reset();
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

    usecase = MockRegisterContract();

    controller = RegisterController(usecase);

    Get.put<RegisterController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  group('RegisterShell Integration', () {
    testWidgets('should render page', (tester) async {
      await tester.pumpWidget(wrapper(const RegisterShell()));

      expect(find.text('Cadastrar'), findsOneWidget);
    });

    testWidgets('should toggle password via controller', (tester) async {
      await tester.pumpWidget(wrapper(const RegisterShell()));

      expect(controller.obscurePassword.value, true);

      await tester.tap(find.byIcon(Icons.visibility_outlined).first);
      await tester.pump();

      expect(controller.obscurePassword.value, false);
    });

    testWidgets('should update loading state', (tester) async {
      await tester.pumpWidget(wrapper(const RegisterShell()));

      controller.isLoading.value = true;
      await tester.pump();

      expect(controller.isLoading.value, true);
    });
  });
}
