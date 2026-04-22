import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgotPasswordController({required this.authRepository});

  final emailController = TextEditingController();
  final isLoading = false.obs;
  final hasSentEmail = false.obs;
  final submittedEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map && arguments['email'] is String) {
      emailController.text = (arguments['email'] as String).trim();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendResetEmail() async {
    final l10n = lookupAppLocalizations(Get.locale ?? const Locale('pt'));
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        l10n.warningTitle,
        l10n.requiredEmail,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final result = await authRepository.sendPasswordResetEmail(email: email);
    isLoading.value = false;

    switch (result) {
      case Success<bool>():
        submittedEmail.value = email;
        hasSentEmail.value = true;
        Get.snackbar(
          l10n.registerSuccessTitle,
          l10n.passwordResetEmailSentMessage(email),
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  void editEmail() {
    hasSentEmail.value = false;
  }
}
