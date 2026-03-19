import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';

class RegisterController extends GetxController {
  final isLoading = false.obs;
  final screenError = Rxn<AppError>();

  final acceptedTerms = true.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final selectedCountryCode = '+55'.obs;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void toggleTerms() {
    acceptedTerms.value = !acceptedTerms.value;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void setCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  Future<void> register() async {
    screenError.value = null;
    isLoading.value = true;

    try {
      // aqui depois entra validação + usecase
      await Future.delayed(const Duration(milliseconds: 800));
    } catch (_) {
      // screenError.value = AlgumErro();
    } finally {
      isLoading.value = false;
    }
  }
}
