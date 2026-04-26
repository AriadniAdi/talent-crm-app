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
  String get noInternet => 'Sin conexión a internet. Verifica tu conexión e inténtalo nuevamente.';

  @override
  String get serverError => 'Ocurrió un error en el servidor. Inténtalo más tarde.';

  @override
  String get notFound => 'El recurso solicitado no fue encontrado.';

  @override
  String get invalidFormat => 'Recibimos una respuesta inesperada del servidor.';

  @override
  String get invalidRoute => 'La página que intentaste acceder es inválida.';

  @override
  String get unknownError => 'Ocurrió un error inesperado. Inténtalo nuevamente.';

  @override
  String get copy => 'Copiar';

  @override
  String get observations => 'Observaciones';

  @override
  String get talentNotFound => 'Talento no encontrado.';

  @override
  String get stopRecording => 'Detener grabación';

  @override
  String get recordObservation => 'Grabar observación';

  @override
  String get noRecordingsYet => 'Ninguna grabación aún';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles';

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
  String get passwordTooShort => 'La contraseña debe tener al menos 6 caracteres';

  @override
  String get invalidNameLength => 'Nombre muy largo';

  @override
  String get requiredCpf => 'CPF obligatorio';

  @override
  String get futureBirthDate => 'La fecha de nacimiento no puede ser futura';

  @override
  String get requiredEmail => 'E-mail obligatorio';

  @override
  String get requiredPhone => 'Teléfono obligatorio';

  @override
  String get requiredPassword => 'Senha obligatoria';

  @override
  String get passwordTooLong => 'La contraseña debe tener como máximo 6 caracteres';

  @override
  String get requiredConfirmPassword => 'Confirmación de senha obligatoria';

  @override
  String get invalidName => 'El nombre contiene caracteres inválidos';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get fillOnTheContinue => 'Complete los campos para continuar';

  @override
  String get loginHeadline => 'Accede a tu cuenta';

  @override
  String get loginDescription => 'Ingresa con tu cuenta social o continúa con correo electrónico para seguir candidatos, equipos y oportunidades.';

  @override
  String get loginOptionsTitle => 'Elige cómo quieres entrar';

  @override
  String get loginOptionsSubtitle => 'Un flujo simple, rápido y familiar para comenzar.';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithGoogleDescription => 'Usa la cuenta conectada a tu dispositivo.';

  @override
  String get continueWithFacebook => 'Continuar con Facebook';

  @override
  String get continueWithFacebookDescription => 'Ingresa con tu perfil social tradicional.';

  @override
  String get orDivider => 'o';

  @override
  String get continueWithEmail => 'Continuar con correo electrónico';

  @override
  String get createAccountWithEmail => 'Crear cuenta con correo electrónico';

  @override
  String get loginProtectionMessage => 'Tus datos de acceso permanecen protegidos y puedes cambiar el método de inicio de sesión después.';

  @override
  String providerComingSoon(String provider) {
    return '$provider se conectará en la próxima etapa.';
  }

  @override
  String get emailLoginTitle => 'Inicio de sesión con correo';

  @override
  String get emailLoginSubtitle => 'Ingresa tu correo electrónico y contraseña para acceder.';

  @override
  String get forgotPasswordAction => 'Olvidé mi contraseña';

  @override
  String get forgotPasswordTitle => 'Recuperar contraseña';

  @override
  String get forgotPasswordSubtitle => 'Ingresa tu correo para recibir el enlace de restablecimiento.';

  @override
  String get forgotPasswordHelper => 'Te enviaremos un correo con instrucciones para crear una nueva contraseña y volver a acceder a tu cuenta de forma segura.';

  @override
  String get sendRecoveryEmail => 'Enviar correo de recuperación';

  @override
  String get passwordResetEmailSentTitle => 'Revisa tu correo';

  @override
  String passwordResetEmailSentMessage(String email) {
    return 'Enviamos un enlace de restablecimiento a $email. Abre tu bandeja de entrada y sigue las instrucciones para crear una nueva contraseña.';
  }

  @override
  String get backToLogin => 'Volver al inicio de sesión';

  @override
  String get useAnotherEmail => 'Usar otro correo';

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
  String get authFacebookCancelled => 'Se canceló el inicio de sesión con Facebook';

  @override
  String get authInvalidCredentials => 'Correo o contraseña inválidos';

  @override
  String get authUserNotFound => 'No se encontró una cuenta con ese correo';

  @override
  String get authConfigurationInvalid => 'La configuracion de Firebase de esta app es invalida o expiro. Actualiza la clave de API y el archivo google-services.json del proyecto.';

  @override
  String get authGenericFailure => 'Error en la autenticación';

  @override
  String get microphonePermissionDenied => 'Permiso de micrófono denegado';

  @override
  String get audioPlaybackError => 'Error al reproducir audio';

  @override
  String get noVoicesRegistered => 'Ninguna voz registrada todavía.';

  @override
  String talentIdLabel(String id) {
    return 'Talento ID: $id';
  }

  @override
  String recordingLabel(String id) {
    return 'Grabación $id';
  }

  @override
  String get emailVerificationTitle => 'Verificación de Correo';

  @override
  String get emailVerificationSubtitle => 'Confirma tu correo';

  @override
  String get emailVerificationMessage => 'Enviamos un enlace de confirmación a tu correo electrónico. Por favor, revisa tu bandeja de entrada y sigue las instrucciones para activar tu cuenta.';

  @override
  String get resendEmail => 'Reenviar correo de confirmación';
}
