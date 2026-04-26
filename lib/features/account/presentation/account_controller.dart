import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:talent_crm_app/core/auth_manager.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/account/repositories/user_repository.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

class AccountController extends GetxController {
  final AppLocaleService localeService;
  final UserRepository userRepository;
  final AuthManager authManager;

  AccountController({
    AppLocaleService? localeService,
    UserRepository? userRepository,
    AuthManager? authManager,
  })  : localeService = localeService ?? Get.find<AppLocaleService>(),
        userRepository = userRepository ?? Get.find<UserRepository>(),
        authManager = authManager ?? Get.find<AuthManager>();

  final screenError = Rxn<AppError>();
  final currentUser = Rxn<UserModel>();
  final isLoading = false.obs;
  final isSaving = false.obs;

  Rx<Locale> get currentLocale => localeService.currentLocale;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.onClose();
  }

  Future<void> changeLocale(Locale locale) => localeService.setLocale(locale);

  Future<void> loadProfile() async {
    final user = authManager.user.value;
    if (user == null) {
      screenError.value = InvalidRouteError();
      return;
    }

    isLoading.value = true;
    screenError.value = null;

    try {
      final result = await userRepository.getUser(user.uid);

      result.when(
        success: (userModel) {
          if (userModel != null) {
            currentUser.value = userModel;
            nameController.text = userModel.name;
            phoneController.text = userModel.phone ?? '';
            bioController.text = userModel.bio ?? '';
          } else {
            screenError.value = NotFoundError();
          }
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

  Future<void> saveProfile() async {
    final userModel = currentUser.value;
    if (userModel == null) return;

    final updatedUser = UserModel(
      uid: userModel.uid,
      name: nameController.text.trim(),
      email: userModel.email,
      phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
      countryCode: userModel.countryCode,
      cpf: userModel.cpf,
      bio: bioController.text.trim().isEmpty ? null : bioController.text.trim(),
      birthDate: userModel.birthDate,
      createdAt: userModel.createdAt,
    );

    isSaving.value = true;
    screenError.value = null;

    try {
      final result = await userRepository.updateUser(updatedUser);
      result.when(
        success: (_) {
          currentUser.value = updatedUser;
          Get.snackbar(
            'Sucesso',
            'Dados atualizados com sucesso!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withValues(alpha: 0.1),
            colorText: Colors.green[800],
          );
        },
        failure: (error) {
          screenError.value = error;
          Get.snackbar(
            'Erro',
            'Não foi possível atualizar os dados',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.1),
            colorText: Colors.red[800],
          );
        },
      );
    } finally {
      isSaving.value = false;
    }
  }
}
