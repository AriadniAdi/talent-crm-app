// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get viewProfile => 'Ver Perfil';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get noEmployeesFound => 'No se encontraron empleados';

  @override
  String get recentEmployee => 'Empleados Recientes';

  @override
  String get allEmployees => 'Todos los Empleados';

  @override
  String get home => 'Inicio';

  @override
  String get teams => 'Equipos';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get voiceNotes => 'Notas de Voz';

  @override
  String get searchEmployeeHint => 'Buscar empleado...';

  @override
  String get appTitle => 'Talent CRM';

  @override
  String get noInternet =>
      'Sin conexión a internet. Verifica tu conexión e inténtalo nuevamente.';

  @override
  String get serverError =>
      'Ocurrió un error en el servidor. Inténtalo más tarde.';

  @override
  String get notFound => 'El recurso solicitado no fue encontrado.';

  @override
  String get invalidFormat =>
      'Recibimos una respuesta inesperada del servidor.';

  @override
  String get invalidRoute => 'La página que intentaste acceder es inválida.';

  @override
  String get unknownError =>
      'Ocurrió un error inesperado. Inténtalo nuevamente.';

  @override
  String get copy => 'Copiar';

  @override
  String get observations => 'Observaciones';

  @override
  String get talentNotFound => 'Talent not found.';

  @override
  String get stopRecording => 'Parar gravação';

  @override
  String get recordObservation => 'Gravar observação';

  @override
  String get noRecordingsYet => 'Nenhuma gravação ainda';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get cpf => 'CPF';

  @override
  String get birthDateHint => 'Fecha de nacimiento (dd/mm/yyyy)';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get phone => 'Teléfono';

  @override
  String get register => 'Registrarse';

  @override
  String get invalidEmail => 'Correo inválido';

  @override
  String get invalidCpf => 'CPF inválido';

  @override
  String get invalidBirthDate => 'Fecha inválida';

  @override
  String get underAge => 'Debes ser mayor de edad';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden';

  @override
  String get requiredName => 'Nombre obligatorio';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

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
  String get invalidName => 'El nombre contiene caracteres inválidos';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get fillOnTheContinue => 'Complete los campos para continuar';

  @override
  String get loginHeadline => 'Accede a tu cuenta';

  @override
  String get loginDescription =>
      'Ingresa con tu cuenta social o continúa con correo electrónico para seguir candidatos, equipos y oportunidades.';

  @override
  String get loginOptionsTitle => 'Elige cómo quieres entrar';

  @override
  String get loginOptionsSubtitle =>
      'Un flujo simple, rápido y familiar para comenzar.';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithGoogleDescription =>
      'Usa la cuenta conectada a tu dispositivo.';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get continueWithAppleDescription =>
      'Ideal para un acceso rápido y privado.';

  @override
  String get continueWithFacebook => 'Continuar con Facebook';

  @override
  String get continueWithFacebookDescription =>
      'Ingresa con tu perfil social tradicional.';

  @override
  String get orDivider => 'o';

  @override
  String get continueWithEmail => 'Continuar con correo electrónico';

  @override
  String get createAccountWithEmail => 'Crear cuenta con correo electrónico';

  @override
  String get loginProtectionMessage =>
      'Tus datos de acceso permanecen protegidos y puedes cambiar el método de inicio de sesión después.';

  @override
  String providerComingSoon(String provider) {
    return '$provider se conectará en la próxima etapa.';
  }

  @override
  String get emailLoginTitle => 'Inicio de sesión con correo';

  @override
  String get emailLoginSubtitle =>
      'Ingresa tu correo electrónico y contraseña para acceder.';

  @override
  String get signIn => 'Entrar';

  @override
  String get warningTitle => 'Aviso';

  @override
  String get fillAllFields => 'Completa todos los campos.';

  @override
  String get loginErrorTitle => 'Error al iniciar sesión';

  @override
  String get registerSuccessTitle => 'Éxito';

  @override
  String get registerSuccessMessage => '¡Cuenta creada con éxito!';

  @override
  String get authEmailAlreadyInUse => 'El correo ya está registrado';

  @override
  String get authInvalidEmail => 'Correo electrónico inválido';

  @override
  String get authGoogleCancelled => 'Se canceló el inicio de sesión con Google';

  @override
  String get authAppleCancelled => 'Se canceló el inicio de sesión con Apple';

  @override
  String get authFacebookCancelled =>
      'Se canceló el inicio de sesión con Facebook';

  @override
  String get authInvalidCredentials => 'Correo o contraseña inválidos';

  @override
  String get authGenericFailure => 'Error en la autenticación';
}
