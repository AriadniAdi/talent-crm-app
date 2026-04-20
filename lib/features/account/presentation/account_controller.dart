import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';

class AccountController extends GetxController {
  final String? id;
  final AppLocaleService localeService;

  AccountController(
    this.id, {
    AppLocaleService? localeService,
  }) : localeService = localeService ?? Get.find<AppLocaleService>();

  final screenError = Rxn<AppError>();

  Rx<Locale> get currentLocale => localeService.currentLocale;

  @override
  void onInit() {
    super.onInit();
    if (id == null) {
      screenError.value = InvalidRouteError();
      return;
    }
  }

  Future<void> changeLocale(Locale locale) => localeService.setLocale(locale);
}
