import 'package:flutter/widgets.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
}
