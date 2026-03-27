import 'package:flutter/widgets.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';
import 'app_error.dart';

extension AppErrorX on AppError {
  String message(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (this is NetworkError) return t.noInternet;
    if (this is ServerError) return t.serverError;
    if (this is NotFoundError) return t.notFound;
    if (this is ParsingError) return t.invalidFormat;
    if (this is InvalidRouteError) return t.invalidRoute;

    if (this is AuthError) {
      return (this as AuthError).message ?? t.unknownError;
    }

    if (this is ValidationError) {
      final type = (this as ValidationError).type;

      switch (type) {
        case ValidationErrorType.requiredName:
          return t.requiredName;
        case ValidationErrorType.invalidNameLength:
          return t.invalidNameLength;
        case ValidationErrorType.requiredCpf:
          return t.requiredCpf;
        case ValidationErrorType.invalidCpf:
          return t.invalidCpf;
        case ValidationErrorType.invalidBirthDate:
          return t.invalidBirthDate;
        case ValidationErrorType.futureBirthDate:
          return t.futureBirthDate;
        case ValidationErrorType.underAge:
          return t.underAge;
        case ValidationErrorType.requiredEmail:
          return t.requiredEmail;
        case ValidationErrorType.invalidEmail:
          return t.invalidEmail;
        case ValidationErrorType.requiredPhone:
          return t.requiredPhone;
        case ValidationErrorType.requiredPassword:
          return t.requiredPassword;
        case ValidationErrorType.passwordTooLong:
          return t.passwordTooLong;
        case ValidationErrorType.requiredConfirmPassword:
          return t.requiredConfirmPassword;
        case ValidationErrorType.passwordMismatch:
          return t.passwordMismatch;
        case ValidationErrorType.invalidName:
          return t.invalidName;
      }
    }

    return t.unknownError;
  }
}
