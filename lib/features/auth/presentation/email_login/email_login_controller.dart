import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

class EmailLoginController extends GetxController {
  final AuthRepository authRepository;

  EmailLoginController({required this.authRepository});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signIn() async {
    final l10n = lookupAppLocalizations(Get.locale ?? const Locale('pt'));
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        l10n.warningTitle,
        l10n.fillAllFields,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    switch (result) {
      case Success<bool>():
        // AuthManager cuidará do redirecionamento
        break;
      case Failure<bool>(error: final error):
        Get.snackbar(
          l10n.loginErrorTitle,
          error.localized(l10n),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        break;
    }
  }
}
