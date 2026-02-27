// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get viewProfile => 'Ver Perfil';

  @override
  String get tryAgain => 'Tentar Novamente';

  @override
  String get noEmployeesFound => 'Nenhum funcionário encontrado';

  @override
  String get recentEmployee => 'Funcionários Recentes';

  @override
  String get allEmployees => 'Todos os Funcionários';

  @override
  String get home => 'Início';

  @override
  String get teams => 'Equipes';

  @override
  String get notifications => 'Notificações';

  @override
  String get voiceNotes => 'Notas de Voz';

  @override
  String get searchEmployeeHint => 'Buscar funcionário...';

  @override
  String get appTitle => 'Talent CRM';

  @override
  String get noInternet => 'Sem conexão com a internet. Verifique sua conexão e tente novamente.';

  @override
  String get serverError => 'Ocorreu um erro no servidor. Tente novamente mais tarde.';

  @override
  String get notFound => 'O recurso solicitado não foi encontrado.';

  @override
  String get invalidFormat => 'Recebemos uma resposta inesperada do servidor.';

  @override
  String get invalidRoute => 'A página que você tentou acessar é inválida.';

  @override
  String get unknownError => 'Ocorreu um erro inesperado. Tente novamente.';
}
