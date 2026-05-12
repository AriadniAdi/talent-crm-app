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

  @override
  String get copy => 'Copy';

  @override
  String get observations => 'Observations';

  @override
  String get talentNotFound => 'Talent not found.';

  @override
  String get stopRecording => 'Stop recording';

  @override
  String get recordObservation => 'Record observation';

  @override
  String get noRecordingsYet => 'No recordings yet';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get fullName => 'Full name';

  @override
  String get cpf => 'CPF';

  @override
  String get birthDateHint => 'Birth date (mm/dd/yyyy)';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get phone => 'Phone';

  @override
  String get register => 'Register';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get invalidCpf => 'Invalid CPF';

  @override
  String get invalidBirthDate => 'Invalid date';

  @override
  String get underAge => 'You must be at least 18 years old';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get requiredName => 'Name is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get invalidNameLength => 'Name is too long';

  @override
  String get requiredCpf => 'CPF is required';

  @override
  String get futureBirthDate => 'Birth date cannot be in the future';

  @override
  String get requiredEmail => 'Email is required';

  @override
  String get requiredPhone => 'Phone is required';

  @override
  String get requiredPassword => 'Password is required';

  @override
  String get passwordTooLong => 'Password must be at most 6 characters';

  @override
  String get requiredConfirmPassword => 'Password confirmation is required';

  @override
  String get invalidName => 'The name contains invalid characters';

  @override
  String get createAccount => 'Create account';

  @override
  String get fillOnTheContinue => 'Fill in the fields to continue';

  @override
  String get loginHeadline => 'Access your account';

  @override
  String get loginDescription => 'Sign in with your social account or continue with email to follow candidates, teams, and opportunities.';

  @override
  String get loginOptionsTitle => 'Choose how you want to sign in';

  @override
  String get loginOptionsSubtitle => 'A simple, fast, and familiar flow to get started.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithGoogleDescription => 'Use the account connected to your device.';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get continueWithFacebookDescription => 'Sign in with your traditional social profile.';

  @override
  String get orDivider => 'or';

  @override
  String get continueWithEmail => 'Continue with email';

  @override
  String get createAccountWithEmail => 'Create account with email';

  @override
  String get loginProtectionMessage => 'Your access data stays protected, and you can switch login methods later.';

  @override
  String providerComingSoon(String provider) {
    return '$provider will be connected in the next step.';
  }

  @override
  String get emailLoginTitle => 'Email login';

  @override
  String get emailLoginSubtitle => 'Enter your email and password to sign in.';

  @override
  String get forgotPasswordAction => 'Forgot my password';

  @override
  String get forgotPasswordTitle => 'Recover password';

  @override
  String get forgotPasswordSubtitle => 'Enter your email to receive the reset link.';

  @override
  String get forgotPasswordHelper => 'We will send an email with instructions to create a new password and safely access your account again.';

  @override
  String get sendRecoveryEmail => 'Send recovery email';

  @override
  String get passwordResetEmailSentTitle => 'Check your email';

  @override
  String passwordResetEmailSentMessage(String email) {
    return 'We sent a reset link to $email. Open your inbox and follow the instructions to create a new password.';
  }

  @override
  String get backToLogin => 'Back to login';

  @override
  String get useAnotherEmail => 'Use another email';

  @override
  String get signIn => 'Sign in';

  @override
  String get warningTitle => 'Warning';

  @override
  String get fillAllFields => 'Fill in all fields.';

  @override
  String get loginErrorTitle => 'Sign-in error';

  @override
  String get registerSuccessTitle => 'Success';

  @override
  String get registerSuccessMessage => 'Account created successfully!';

  @override
  String get authEmailAlreadyInUse => 'Email already registered';

  @override
  String get authInvalidEmail => 'Invalid email';

  @override
  String get authGoogleCancelled => 'Google sign-in was canceled';

  @override
  String get authFacebookCancelled => 'Facebook sign-in was canceled';

  @override
  String get authInvalidCredentials => 'Invalid email or password';

  @override
  String get authUserNotFound => 'No account was found with this email';

  @override
  String get authConfigurationInvalid => 'This app\'s Firebase configuration is invalid or expired. Update the API key and the project\'s google-services.json file.';

  @override
  String get authGenericFailure => 'Authentication failed';

  @override
  String get microphonePermissionDenied => 'Microphone permission denied';

  @override
  String get audioPlaybackError => 'Error playing audio';

  @override
  String get noVoicesRegistered => 'No voices registered yet.';

  @override
  String talentIdLabel(String id) {
    return 'Talent ID: $id';
  }

  @override
  String recordingLabel(String id) {
    return 'Recording $id';
  }

  @override
  String get emailVerificationTitle => 'Email Verification';

  @override
  String get emailVerificationSubtitle => 'Confirm your email';

  @override
  String get emailVerificationMessage => 'We sent a confirmation link to your email. Please check your inbox and follow the instructions to activate your account.';

  @override
  String get resendEmail => 'Resend confirmation email';
}
