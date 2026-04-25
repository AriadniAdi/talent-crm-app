import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

class EmailVerificationController extends GetxController {
  final AuthRepository _authRepository;

  EmailVerificationController(this._authRepository);

  final isLoading = false.obs;
  final isResending = false.obs;
  final error = Rxn<AppError>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startPolling();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future<void> checkEmailVerified() async {
    final result = await _authRepository.reloadUser();

    if (result is Failure) {
      error.value = result.error;
    } else {
      // Firebase reload doesn't always trigger authStateChanges stream immediately
      // So we manually check and trigger navigation if verified
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        Get.offAllNamed(AppRoutes.home);
      }
    }
  }

  Future<void> resendVerificationEmail() async {
    isResending.value = true;
    error.value = null;

    final result = await _authRepository.sendEmailVerification();

    if (result is Failure) {
      error.value = result.error;
    }

    isResending.value = false;
  }

  Future<void> signOut() async {
    isLoading.value = true;
    await _authRepository.signOut();
    isLoading.value = false;
  }
}
