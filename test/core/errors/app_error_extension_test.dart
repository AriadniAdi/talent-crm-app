import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/l10n/app_localizations_pt.dart';

void main() {
  const translations = AppLocalizationsPt();

  group('AppErrorX', () {
    test('returns provider-specific authentication message when available', () {
      final error = AuthError(
        'Google Sign-In configuration is invalid.',
        AuthErrorCode.authenticationFailed,
      );

      expect(
        error.localized(translations),
        'Google Sign-In configuration is invalid.',
      );
    });

    test('falls back to generic authentication message when no message exists',
        () {
      final error = AuthError.withCode(AuthErrorCode.authenticationFailed);

      expect(error.localized(translations), translations.authGenericFailure);
    });
  });
}
