import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:talent_crm_app/features/register/presentation/register_shell.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';

import '../../helpers/wrapper.dart';

void main() {
  late RegisterController controller;
  late RegisterUseCase usecase;

  setUp(() {
    Get.reset();
    Get.testMode = true;

    usecase = const RegisterUseCase();

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

    testWidgets('should toggle terms via controller', (tester) async {
      await tester.pumpWidget(wrapper(const RegisterShell()));

      expect(controller.acceptedTerms.value, true);

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(controller.acceptedTerms.value, false);
    });

    testWidgets('should update loading state', (tester) async {
      await tester.pumpWidget(wrapper(const RegisterShell()));

      controller.isLoading.value = true;
      await tester.pump();

      expect(controller.isLoading.value, true);
    });
  });
}
