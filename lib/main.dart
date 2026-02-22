import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/home/presentation/home_binding.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talent_crm_app/features/home/presentation/home_shell.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialBinding: HomeBinding(),
      home: const HomeShell(),
    );
  }
}
