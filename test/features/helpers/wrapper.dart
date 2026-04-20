import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';
import 'package:talent_crm_app/features/talent/data/repositories/talent_repository_impl.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

Widget wrapper(
  Widget child, {
  Widget? bottomNavigationBar,
  Size? surfaceSize,
  bool center = false,
  Locale locale = const Locale('pt'),
}) {
  if (!Get.isRegistered<AppLocaleService>()) {
    Get.put<AppLocaleService>(
      AppLocaleService.inMemory(initialLocale: locale),
    );
  }

  Widget content = child;

  if (center) {
    content = Center(child: content);
  }

  if (surfaceSize != null) {
    content = SizedBox(
      width: surfaceSize.width,
      height: surfaceSize.height,
      child: content,
    );
  }
  final localeService = Get.find<AppLocaleService>();

  return Obx(
    () => GetMaterialApp(
      locale: localeService.currentLocale.value,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Scaffold(
            body: content,
            bottomNavigationBar: bottomNavigationBar,
          ),
        ),
        GetPage(
          name: AppRoutes.account,
          page: () => const Scaffold(
            key: Key('Account Page'),
          ),
        ),
        GetPage(
          name: AppRoutes.talent,
          page: () => const Scaffold(
            key: Key('Talent Page'),
          ),
        ),
        GetPage(
          name: AppRoutes.home,
          page: () => const Scaffold(
            key: Key('Home'),
          ),
        ),
        GetPage(
          name: AppRoutes.login,
          page: () => const Scaffold(
            key: Key('Login'),
          ),
        ),
      ],
    ),
  );
}

void setupTestDependencies<T extends GetxController>({T? mockController}) {
  if (mockController != null) {
    Get.put<T>(mockController);
  }

  Get.put<http.Client>(http.Client());
  Get.put<ApiClient>(ApiClient(Get.find()));
  Get.lazyPut<TalentRemoteDataSource>(
    () => TalentRemoteDataSource(apiClient: Get.find()),
  );
  Get.lazyPut<TalentRepository>(() => TalentRepositoryImpl(Get.find<TalentRemoteDataSource>()));
}
