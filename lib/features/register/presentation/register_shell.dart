import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';
import 'register_page.dart';

class RegisterShell extends GetView<RegisterController> {
  const RegisterShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RegisterPage(
        fullNameController: controller.fullNameController,
        emailController: controller.emailController,
        passwordController: controller.passwordController,
        confirmPasswordController: controller.confirmPasswordController,
        phoneController: controller.phoneController,
        obscurePassword: controller.obscurePassword.value,
        obscureConfirmPassword: controller.obscureConfirmPassword.value,
        selectedCountryCode: controller.selectedCountryCode.value,
        isLoading: controller.isLoading.value,
        errorMessage: controller.screenError.value?.message(context),
        onTogglePassword: controller.togglePasswordVisibility,
        onToggleConfirmPassword: controller.toggleConfirmPasswordVisibility,
        onRegister: controller.register,
        cpfController: controller.cpfController,
        birthDateController: controller.birthDateController,
        errorMessages:
            controller.validationErrors.map((e) => e.message(context)).toList(),
        onCountryTap: () {
          _showCountryCodeSheet(context);
        },
        hasError: controller.hasError,
        getErrorMessage: controller.getErrorMessage,
        onBirthDateChanged: controller.onBirthDateChanged,
        cpfFormatters: [controller.cpfMask],
        dateFormatters: [controller.dateMask],
        phoneFormatters: [controller.phoneMask],
      ),
    );
  }

  void _showCountryCodeSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _option('+55'),
              _option('+54'),
              _option('+1'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(String code) {
    return ListTile(
      title: Text(code),
      onTap: () {
        controller.setCountryCode(code);
        Get.back();
      },
    );
  }
}
