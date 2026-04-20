import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleOption {
  final Locale locale;
  final String nativeLabel;

  const AppLocaleOption({
    required this.locale,
    required this.nativeLabel,
  });
}

class AppLocaleService extends GetxService {
  static const storageKey = 'app_locale_code';
  static const fallbackLocale = Locale('pt');
  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];
  static const supportedOptions = <AppLocaleOption>[
    AppLocaleOption(locale: Locale('pt'), nativeLabel: 'Português'),
    AppLocaleOption(locale: Locale('en'), nativeLabel: 'English'),
    AppLocaleOption(locale: Locale('es'), nativeLabel: 'Español'),
  ];

  final SharedPreferences? _preferences;
  final Rx<Locale> currentLocale;

  AppLocaleService._(this._preferences, Locale initialLocale)
      : currentLocale = initialLocale.obs;

  factory AppLocaleService(SharedPreferences preferences) {
    final savedCode = preferences.getString(storageKey);
    return AppLocaleService._(preferences, _resolve(savedCode));
  }

  factory AppLocaleService.inMemory({Locale? initialLocale}) {
    return AppLocaleService._(null, initialLocale ?? fallbackLocale);
  }

  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale)) return;

    currentLocale.value = locale;
    await _preferences?.setString(storageKey, locale.languageCode);
  }

  String languageName(Locale locale) {
    return supportedOptions
        .firstWhere(
          (option) => option.locale.languageCode == locale.languageCode,
          orElse: () => supportedOptions.last,
        )
        .nativeLabel;
  }

  static Locale _resolve(String? code) {
    final locale = supportedLocales.firstWhereOrNull(
      (item) => item.languageCode == code,
    );

    return locale ?? fallbackLocale;
  }

  static bool _isSupported(Locale locale) {
    return supportedLocales.any(
      (item) => item.languageCode == locale.languageCode,
    );
  }
}
