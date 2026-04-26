import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('route values are correct', () {
      expect(AppRoutes.splash, '/');
      expect(AppRoutes.login, '/login');
      expect(AppRoutes.loginEmail, '/loginEmail');
      expect(AppRoutes.forgotPassword, '/forgotPassword');
      expect(AppRoutes.home, '/home');
      expect(AppRoutes.account, '/account');
      expect(AppRoutes.talent, '/talent');
    });

    test('all routes start with "/"', () {
      final routes = [
        AppRoutes.splash,
        AppRoutes.login,
        AppRoutes.loginEmail,
        AppRoutes.forgotPassword,
        AppRoutes.home,
        AppRoutes.account,
        AppRoutes.talent,
      ];

      for (final route in routes) {
        expect(route.startsWith('/'), true);
      }
    });

    test('routes are unique', () {
      final routes = [
        AppRoutes.splash,
        AppRoutes.login,
        AppRoutes.loginEmail,
        AppRoutes.forgotPassword,
        AppRoutes.home,
        AppRoutes.account,
        AppRoutes.talent,
      ];

      expect(routes.length, routes.toSet().length);
    });
  });
}
