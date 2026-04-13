import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/register/presentation/register_page.dart';

import '../../../helpers/wrapper.dart';

void main() {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  late TextEditingController cpfController;
  late TextEditingController birthDateController;

  setUp(() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
    cpfController = TextEditingController();
    birthDateController = TextEditingController();
  });

  tearDown(() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    cpfController.dispose();
    birthDateController.dispose();

    Get.reset();
  });

  Future<void> pumpCleanWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    });
  }

  Finder textFieldByHint(String hint) {
    return find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.hintText == hint,
      description: 'TextField com hint "$hint"',
    );
  }

  RegisterPage buildPage({
    bool isLoading = false,
    bool obscurePassword = true,
    bool obscureConfirmPassword = true,
    String countryCode = '+55',
    String errorMessage = '',
    List<String> errorMessages = const [],
    bool Function(FieldType field)? hasError,
    String? Function(FieldType field, BuildContext context)? getErrorMessage,
    void Function(String value)? onBirthDateChanged,
    VoidCallback? onRegister,
    VoidCallback? onTogglePassword,
    VoidCallback? onToggleConfirmPassword,
    VoidCallback? onCountryTap,
    List<TextInputFormatter> cpfFormatters = const [],
    List<TextInputFormatter> dateFormatters = const [],
    List<TextInputFormatter> phoneFormatters = const [],
  }) {
    return RegisterPage(
      fullNameController: fullNameController,
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      phoneController: phoneController,
      obscurePassword: obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword,
      selectedCountryCode: countryCode,
      isLoading: isLoading,
      onRegister: onRegister ?? () {},
      onTogglePassword: onTogglePassword ?? () {},
      onToggleConfirmPassword: onToggleConfirmPassword ?? () {},
      onCountryTap: onCountryTap ?? () {},
      cpfController: cpfController,
      birthDateController: birthDateController,
      errorMessage: errorMessage,
      errorMessages: errorMessages,
      hasError: hasError ?? (FieldType field) => false,
      getErrorMessage:
          getErrorMessage ?? (FieldType field, BuildContext context) => null,
      onBirthDateChanged: onBirthDateChanged ?? (String value) {},
      cpfFormatters: cpfFormatters,
      dateFormatters: dateFormatters,
      phoneFormatters: phoneFormatters,
    );
  }

  group('RegisterPage Render', () {
    testWidgets('should render all fields', (tester) async {
      await pumpCleanWidget(
        tester,
        wrapper(buildPage()),
      );

      expect(find.text('Nome completo'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
      expect(find.text('Confirmar senha'), findsOneWidget);
      expect(find.text('Telefone'), findsOneWidget);
      expect(find.text('CPF'), findsOneWidget);
      expect(find.text('Data de nascimento (dd/mm/yyyy)'), findsOneWidget);
      expect(find.text('Cadastrar'), findsOneWidget);
    });

    testWidgets('should render field error message for email', (tester) async {
      await pumpCleanWidget(
        tester,
        wrapper(
          buildPage(
            hasError: (field) => field == FieldType.email,
            getErrorMessage: (field, context) {
              if (field == FieldType.email) {
                return 'E-mail inválido';
              }
              return null;
            },
          ),
        ),
      );

      expect(find.text('E-mail inválido'), findsOneWidget);
    });
  });

  group('RegisterPage Actions', () {
    testWidgets('should call onRegister when tapping register button',
        (tester) async {
      var called = false;

      await pumpCleanWidget(
        tester,
        wrapper(
          buildPage(
            onRegister: () {
              called = true;
            },
          ),
        ),
      );

      final registerFinder = find.text('Cadastrar');

      await tester.scrollUntilVisible(
        registerFinder,
        200,
        scrollable: find.byType(Scrollable).first,
      );

      await tester.tap(registerFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(called, isTrue);
    });
  });

  group('RegisterPage Controllers', () {
    testWidgets('should keep typed values in controllers', (tester) async {
      await pumpCleanWidget(
        tester,
        wrapper(buildPage()),
      );

      await tester.enterText(textFieldByHint('Nome completo'), 'João Silva');
      await tester.enterText(textFieldByHint('E-mail'), 'joao@email.com');
      await tester.enterText(textFieldByHint('Senha'), '123456');
      await tester.enterText(textFieldByHint('Confirmar senha'), '123456');
      await tester.enterText(textFieldByHint('Telefone'), '999999999');

      final cpfField = textFieldByHint('CPF');
      await tester.scrollUntilVisible(
        cpfField,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.enterText(cpfField, '52998224725');

      final birthDateField = textFieldByHint('Data de nascimento (dd/mm/yyyy)');
      await tester.scrollUntilVisible(
        birthDateField,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.enterText(birthDateField, '01/01/2000');

      await tester.pumpAndSettle();

      expect(fullNameController.text, 'João Silva');
      expect(emailController.text, 'joao@email.com');
      expect(passwordController.text, '123456');
      expect(confirmPasswordController.text, '123456');
      expect(phoneController.text, '999999999');
      expect(cpfController.text, '52998224725');
      expect(birthDateController.text, '01/01/2000');
    });
  });
}
