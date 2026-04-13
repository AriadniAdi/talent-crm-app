import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/register/presentation/register_page.dart';
import '../../helpers/wrapper.dart';

class _RegisterPageControllers {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final birthDateController = TextEditingController();
}

void main() {
  RegisterPage buildPage(
    _RegisterPageControllers controllers, {
    bool isLoading = false,
    bool obscurePassword = true,
    bool obscureConfirmPassword = true,
    String countryCode = '+55',
    String? errorMessage,
    List<String> errorMessages = const [],
    bool Function(FieldType field)? hasError,
    String? Function(FieldType field, BuildContext context)? getErrorMessage,
    ValueChanged<String>? onBirthDateChanged,
    VoidCallback? onRegister,
    VoidCallback? onTogglePassword,
    VoidCallback? onToggleConfirmPassword,
    VoidCallback? onCountryTap,
    List<TextInputFormatter> cpfFormatters = const [],
    List<TextInputFormatter> dateFormatters = const [],
    List<TextInputFormatter> phoneFormatters = const [],
  }) {
    return RegisterPage(
      fullNameController: controllers.fullNameController,
      emailController: controllers.emailController,
      passwordController: controllers.passwordController,
      confirmPasswordController: controllers.confirmPasswordController,
      phoneController: controllers.phoneController,
      obscurePassword: obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword,
      selectedCountryCode: countryCode,
      isLoading: isLoading,
      onRegister: onRegister ?? () {},
      onTogglePassword: onTogglePassword ?? () {},
      onToggleConfirmPassword: onToggleConfirmPassword ?? () {},
      onCountryTap: onCountryTap ?? () {},
      cpfController: controllers.cpfController,
      birthDateController: controllers.birthDateController,
      errorMessage: errorMessage,
      errorMessages: errorMessages,
      hasError: hasError ?? (FieldType field) => false,
      getErrorMessage:
          getErrorMessage ?? (FieldType field, BuildContext context) => null,
      onBirthDateChanged: onBirthDateChanged,
      cpfFormatters: cpfFormatters,
      dateFormatters: dateFormatters,
      phoneFormatters: phoneFormatters,
    );
  }

  Future<_RegisterPageControllers> pumpRegisterPage(
    WidgetTester tester, {
    bool isLoading = false,
    bool obscurePassword = true,
    bool obscureConfirmPassword = true,
    String countryCode = '+55',
    String? errorMessage,
    List<String> errorMessages = const [],
    bool Function(FieldType field)? hasError,
    String? Function(FieldType field, BuildContext context)? getErrorMessage,
    ValueChanged<String>? onBirthDateChanged,
    VoidCallback? onRegister,
    VoidCallback? onTogglePassword,
    VoidCallback? onToggleConfirmPassword,
    VoidCallback? onCountryTap,
    List<TextInputFormatter> cpfFormatters = const [],
    List<TextInputFormatter> dateFormatters = const [],
    List<TextInputFormatter> phoneFormatters = const [],
  }) async {
    final controllers = _RegisterPageControllers();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });
    await tester.pumpWidget(
      wrapper(
        buildPage(
          controllers,
          isLoading: isLoading,
          obscurePassword: obscurePassword,
          obscureConfirmPassword: obscureConfirmPassword,
          countryCode: countryCode,
          errorMessage: errorMessage,
          errorMessages: errorMessages,
          hasError: hasError,
          getErrorMessage: getErrorMessage,
          onBirthDateChanged: onBirthDateChanged,
          onRegister: onRegister,
          onTogglePassword: onTogglePassword,
          onToggleConfirmPassword: onToggleConfirmPassword,
          onCountryTap: onCountryTap,
          cpfFormatters: cpfFormatters,
          dateFormatters: dateFormatters,
          phoneFormatters: phoneFormatters,
        ),
      ),
    );
    await tester.pump();
    return controllers;
  }

  group('RegisterPage Render', () {
    testWidgets('should render header and all fields', (tester) async {
      await pumpRegisterPage(tester);
      expect(find.text('Criar conta'), findsOneWidget);
      expect(find.text('Preencha para continuar'), findsOneWidget);
      expect(find.byKey(const Key('register_full_name_field')), findsOneWidget);
      expect(find.byKey(const Key('register_cpf_field')), findsOneWidget);
      expect(
          find.byKey(const Key('register_birth_date_field')), findsOneWidget);
      expect(find.byKey(const Key('register_email_field')), findsOneWidget);
      expect(find.byKey(const Key('register_password_field')), findsOneWidget);
      expect(
        find.byKey(const Key('register_confirm_password_field')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('register_phone_field')), findsOneWidget);
      expect(find.byKey(const Key('register_submit_button')), findsOneWidget);
    });
  });
}
