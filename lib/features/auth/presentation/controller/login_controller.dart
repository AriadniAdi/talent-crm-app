import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;

  LoginController({required this.authRepository});

  final isLoading = false.obs;

  Future<void> continueWithEmail() async {
    Get.toNamed(AppRoutes.loginEmail);
  }

  Future<void> continueWithGoogle() async {
    await _continueWithProvider(authRepository.signInWithGoogle);
  }

  Future<void> continueWithFacebook() async {
    await _continueWithProvider(authRepository.signInWithFacebook);
  }

  Future<void> _continueWithProvider(
      Future<Result<bool>> Function() signIn) async {
    if (isLoading.value) {
      return;
    }

    isLoading.value = true;
    final result = await signIn();
    isLoading.value = false;

    switch (result) {
      case Success<bool>():
        // AuthManager cuidará da navegação global automaticamente!
        break;
      case Failure<bool>(error: final error):
        final l10n = lookupAppLocalizations(Get.locale ?? const Locale('pt'));
        Get.snackbar(
          l10n.warningTitle,
          error.localized(l10n),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        break;
    }
  }
}
