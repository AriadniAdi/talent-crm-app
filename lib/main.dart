import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/deep_link/deep_link_service.dart';
import 'package:talent_crm_app/core/global_binding.dart';
import 'package:talent_crm_app/core/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/firebase_options.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GoogleSignIn.instance.initialize();

  DeepLinkService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: const Key('my-app-key'),
      initialBinding: GlobalBinding(),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
