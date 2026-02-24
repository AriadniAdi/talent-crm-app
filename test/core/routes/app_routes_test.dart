import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('route values are correct', () {
      expect(AppRoutes.splash, '/');
      expect(AppRoutes.home, '/home');
      expect(AppRoutes.account, '/account');
    });

    test('all routes start with "/"', () {
      final routes = [
        AppRoutes.splash,
        AppRoutes.home,
        AppRoutes.account,
      ];

      for (final route in routes) {
        expect(route.startsWith('/'), true);
      }
    });

    test('routes are unique', () {
      final routes = [
        AppRoutes.splash,
        AppRoutes.home,
        AppRoutes.account,
      ];

      expect(routes.length, routes.toSet().length);
    });
  });
}
