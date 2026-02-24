import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/routes/app_pages.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/account/account_binding.dart';
import 'package:talent_crm_app/features/home/home_binding.dart';

void main() {
  group('AppPages', () {
    test('initial route is home', () {
      expect(AppPages.initial, AppRoutes.home);
    });

    test('contains splash route', () {
      final splashRoute =
          AppPages.pages.firstWhere((page) => page.name == AppRoutes.splash);

      expect(splashRoute.name, AppRoutes.splash);
      expect(splashRoute.binding, isNull);
    });

    test('contains home route with binding', () {
      final homeRoute =
          AppPages.pages.firstWhere((page) => page.name == AppRoutes.home);

      expect(homeRoute.binding, isA<HomeBinding>());
    });

    test('contains account route with binding', () {
      final accountRoute =
          AppPages.pages.firstWhere((page) => page.name == AppRoutes.account);

      expect(accountRoute.binding, isA<AccountBinding>());
    });

    test('all route names are unique', () {
      final names = AppPages.pages.map((e) => e.name).toList();
      final uniqueNames = names.toSet();

      expect(names.length, uniqueNames.length);
    });
  });
}
