import 'package:get/get.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/account/account_binding.dart';
import 'package:talent_crm_app/features/account/presentation/account_shell.dart';
import 'package:talent_crm_app/features/auth/presentation/login_binding.dart';
import 'package:talent_crm_app/features/auth/presentation/login_shell.dart';
import 'package:talent_crm_app/features/auth/presentation/email_login/email_login_page.dart';
import 'package:talent_crm_app/features/auth/presentation/email_login/email_login_binding.dart';
import 'package:talent_crm_app/features/home/home_binding.dart';
import 'package:talent_crm_app/features/home/presentation/home_shell.dart';
import 'package:talent_crm_app/features/register/presentation/register_binding.dart';
import 'package:talent_crm_app/features/register/presentation/register_shell.dart';
import 'package:talent_crm_app/features/splash/splash_page.dart';
import 'package:talent_crm_app/features/voice/presentation/voices_binding.dart';
import 'package:talent_crm_app/features/voice/presentation/voices_page.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_binding.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_shell.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginShell(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.loginEmail,
      page: () => const EmailLoginPage(),
      binding: EmailLoginBinding(),
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
    GetPage(
      name: AppRoutes.talent,
      page: () => const TalentShell(),
      binding: TalentBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterShell(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.voices,
      page: () => const VoicesPage(),
      binding: VoicesBinding(),
    ),
  ];
}
