import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// Button label to view the employee profile
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// Retry button label when an error occurs
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Message displayed when no employees are available
  ///
  /// In en, this message translates to:
  /// **'No employees found'**
  String get noEmployeesFound;

  /// Section title that displays recently added or viewed employees
  ///
  /// In en, this message translates to:
  /// **'Recent Employees'**
  String get recentEmployee;

  /// Section title that displays the full list of employees
  ///
  /// In en, this message translates to:
  /// **'All Employees'**
  String get allEmployees;

  /// Bottom navigation label for home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Bottom navigation label for teams tab
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// Bottom navigation label for notifications tab
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Bottom navigation label for voice notes tab
  ///
  /// In en, this message translates to:
  /// **'Voice Notes'**
  String get voiceNotes;

  /// Hint text displayed in the employee search field
  ///
  /// In en, this message translates to:
  /// **'Search employee...'**
  String get searchEmployeeHint;

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'Talent CRM'**
  String get appTitle;

  /// Shown when the device has no internet connection and a network request fails.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your connection and try again.'**
  String get noInternet;

  /// Shown when the server returns an unexpected error (e.g., 500).
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Please try again later.'**
  String get serverError;

  /// Shown when a requested resource cannot be found (e.g., 404).
  ///
  /// In en, this message translates to:
  /// **'The requested resource was not found.'**
  String get notFound;

  /// Shown when the response format from the server is invalid or cannot be parsed.
  ///
  /// In en, this message translates to:
  /// **'We received an unexpected response from the server.'**
  String get invalidFormat;

  /// Shown when navigation is attempted with invalid or missing route parameters.
  ///
  /// In en, this message translates to:
  /// **'The page you tried to access is invalid.'**
  String get invalidRoute;

  /// Fallback message shown when an unknown or unhandled error occurs.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unknownError;

  /// Default message displayed to the user to let them know that the text has been copied
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Section title where talent-related observations are displayed.
  ///
  /// In en, this message translates to:
  /// **'Observations'**
  String get observations;

  /// Mensaje mostrado cuando el talento solicitado no se encuentra o no existe.
  ///
  /// In en, this message translates to:
  /// **'Talento no encontrado.'**
  String get talentNotFound;

  /// Text displayed on the button to stop audio recording.
  ///
  /// In en, this message translates to:
  /// **'Stop recording'**
  String get stopRecording;

  /// Text displayed on the button to start recording an audio observation.
  ///
  /// In en, this message translates to:
  /// **'Record observation'**
  String get recordObservation;

  /// Message displayed when there are no saved recordings.
  ///
  /// In en, this message translates to:
  /// **'No recordings yet'**
  String get noRecordingsYet;

  /// Message displayed when content is copied to the clipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// Full name field label in registration
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// CPF field label
  ///
  /// In en, this message translates to:
  /// **'CPF'**
  String get cpf;

  /// Birth date field label
  ///
  /// In en, this message translates to:
  /// **'Birth date (mm/dd/yyyy)'**
  String get birthDateHint;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Phone field label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Error when email is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// Error when CPF is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid CPF'**
  String get invalidCpf;

  /// Error when date is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get invalidBirthDate;

  /// Error when user is underage
  ///
  /// In en, this message translates to:
  /// **'You must be at least 18 years old'**
  String get underAge;

  /// Error when passwords do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// Error when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get requiredName;

  /// Error when password is too short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// Error shown when name exceeds allowed length
  ///
  /// In en, this message translates to:
  /// **'Name is too long'**
  String get invalidNameLength;

  /// Error shown when CPF is not provided
  ///
  /// In en, this message translates to:
  /// **'CPF is required'**
  String get requiredCpf;

  /// Error shown when the date is in the future
  ///
  /// In en, this message translates to:
  /// **'Birth date cannot be in the future'**
  String get futureBirthDate;

  /// Error shown when email is empty
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get requiredEmail;

  /// Error shown when phone is empty
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get requiredPhone;

  /// Error shown when password is empty
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get requiredPassword;

  /// Error shown when password exceeds 6 characters
  ///
  /// In en, this message translates to:
  /// **'Password must be at most 6 characters'**
  String get passwordTooLong;

  /// Error shown when confirmation is empty
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get requiredConfirmPassword;

  /// Error shown when the name contains invalid characters such as numbers or symbols
  ///
  /// In en, this message translates to:
  /// **'The name contains invalid characters'**
  String get invalidName;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
