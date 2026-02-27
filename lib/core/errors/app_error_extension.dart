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

    return t.unknownError;
  }
}
