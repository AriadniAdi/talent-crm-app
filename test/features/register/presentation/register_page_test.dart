import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:talent_crm_app/features/register/presentation/register_page.dart';

import '../../helpers/wrapper.dart';

void main() {
  late TextEditingController fullNameController,
      emailController,
      passwordController,
      confirmPasswordController,
      phoneController,
      cpfController,
      birthDateController;

  setUp(() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
    cpfController = TextEditingController();
    birthDateController = TextEditingController();
  });

  RegisterPage buildPage({
    bool isLoading = false,
    bool obscurePassword = true,
    bool obscureConfirmPassword = true,
    String countryCode = '+55',
    VoidCallback? onRegister,
    VoidCallback? onTogglePassword,
    VoidCallback? onToggleConfirmPassword,
    VoidCallback? onToggleTerms,
    VoidCallback? onCountryTap,
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
    );
  }

  group('RegisterPage Render', () {
    testWidgets('should render all fields', (tester) async {
      await tester.pumpWidget(wrapper(buildPage()));

      expect(find.text('Nome completo'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
      expect(find.text('Confirmar senha'), findsOneWidget);
      expect(find.text('Telefone'), findsOneWidget);
      expect(find.text('Cadastrar'), findsOneWidget);
    });
  });
}
