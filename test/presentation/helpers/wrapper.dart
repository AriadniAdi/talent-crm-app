import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
