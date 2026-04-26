import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

class AccountController extends GetxController {
  final String? id;
  final AppLocaleService localeService;
  final AuthRepository authRepository;

  AccountController(
    this.id, {
    AppLocaleService? localeService,
    AuthRepository? authRepository,
  })  : localeService = localeService ?? Get.find<AppLocaleService>(),
        authRepository = authRepository ?? Get.find<AuthRepository>();

  final screenError = Rxn<AppError>();
  final currentUser = Rxn<UserModel>();
  final isLoading = false.obs;
  final isSaving = false.obs;

  Rx<Locale> get currentLocale => localeService.currentLocale;

  @override
  void onInit() {
    super.onInit();
    if (id == null) {
      screenError.value = InvalidRouteError();
      return;
    }

    loadProfile();
  }

  Future<void> changeLocale(Locale locale) => localeService.setLocale(locale);

  Future<void> loadProfile() async {
    final userId = id;
    if (userId == null) {
      screenError.value = InvalidRouteError();
      return;
    }

    isLoading.value = true;
    screenError.value = null;

    try {
      final result = await authRepository.getUserProfile(uid: userId);

      result.when(
        success: (user) {
          currentUser.value = user;
        },
        failure: (error) {
          screenError.value = error;
          currentUser.value = null;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<Result<bool>> saveProfile({
    required String name,
    required String phone,
    required String bio,
  }) async {
    final user = currentUser.value;
    if (user == null) {
      return Failure(NotFoundError());
    }

    final updatedUser = UserModel(
      uid: user.uid,
      name: name.trim(),
      email: user.email,
      phone: phone.trim().isEmpty ? null : phone.trim(),
      countryCode: user.countryCode,
      cpf: user.cpf,
      bio: bio.trim().isEmpty ? null : bio.trim(),
      birthDate: user.birthDate,
      createdAt: user.createdAt,
    );

    isSaving.value = true;

    try {
      final result = await authRepository.updateUserProfile(user: updatedUser);
      result.when(
        success: (_) {
          currentUser.value = updatedUser;
        },
        failure: (_) {},
      );

      return result;
    } finally {
      isSaving.value = false;
    }
  }
}
