// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get viewProfile => 'View Profile';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get noEmployeesFound => 'No employees found';

  @override
  String get recentEmployee => 'Recent Employees';

  @override
  String get allEmployees => 'All Employees';

  @override
  String get home => 'Home';

  @override
  String get teams => 'Teams';

  @override
  String get notifications => 'Notifications';

  @override
  String get voiceNotes => 'Voice Notes';

  @override
  String get searchEmployeeHint => 'Search employee...';

  @override
  String get appTitle => 'Talent CRM';

  @override
  String get noInternet => 'No internet connection. Please check your connection and try again.';

  @override
  String get serverError => 'Something went wrong on our side. Please try again later.';

  @override
  String get notFound => 'The requested resource was not found.';

  @override
  String get invalidFormat => 'We received an unexpected response from the server.';

  @override
  String get invalidRoute => 'The page you tried to access is invalid.';

  @override
  String get unknownError => 'An unexpected error occurred. Please try again.';
}
