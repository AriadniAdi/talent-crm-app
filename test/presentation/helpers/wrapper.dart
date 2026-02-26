import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

Widget wrapper(Widget child, {Size? surfaceSize, bool center = false}) {
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
  return GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(
        name: '/',
        page: () => Scaffold(body: content),
      ),
      GetPage(
        name: AppRoutes.account,
        page: () => const Scaffold(
          body: Text('Account Page'),
        ),
      ),
      GetPage(
        name: AppRoutes.talent,
        page: () => const Scaffold(
          body: Text('Account Page'),
        ),
      ),
    ],
    locale: const Locale('pt'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: content),
  );
}
