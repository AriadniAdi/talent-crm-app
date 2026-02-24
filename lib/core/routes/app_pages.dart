import 'package:get/get.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/account/account_binding.dart';
import 'package:talent_crm_app/features/account/presentation/account_shell.dart';
import 'package:talent_crm_app/features/home/home_binding.dart';
import 'package:talent_crm_app/features/home/presentation/home_shell.dart';
import 'package:talent_crm_app/features/splash/splash_page.dart';

class AppPages {
  static const initial = AppRoutes.home;

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeShell(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountShell(),
      binding: AccountBinding(),
    ),
  ];
}
