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

  @override
  String get copy => 'Copiar';

  @override
  String get observations => 'Observações';

  @override
  String get talentNotFound => 'Talento não encontrado.';

  @override
  String get stopRecording => 'Parar gravação';

  @override
  String get recordObservation => 'Gravar observação';

  @override
  String get noRecordingsYet => 'Nenhuma gravação ainda';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get fullName => 'Nome completo';

  @override
  String get cpf => 'CPF';

  @override
  String get birthDateHint => 'Data de nascimento (dd/mm/yyyy)';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get phone => 'Telefone';

  @override
  String get register => 'Cadastrar';

  @override
  String get invalidEmail => 'E-mail inválido';

  @override
  String get invalidCpf => 'CPF inválido';

  @override
  String get invalidBirthDate => 'Data inválida';

  @override
  String get underAge => 'Você precisa ser maior de idade';

  @override
  String get passwordMismatch => 'Senhas não coincidem';

  @override
  String get requiredName => 'Nome obrigatório';

  @override
  String get passwordTooShort => 'Senha deve ter pelo menos 6 caracteres';

  @override
  String get invalidNameLength => 'Nome muito longo';

  @override
  String get requiredCpf => 'CPF obrigatório';

  @override
  String get futureBirthDate => 'A data de nascimento não pode ser futura';

  @override
  String get requiredEmail => 'E-mail obrigatório';

  @override
  String get requiredPhone => 'Telefone obrigatório';

  @override
  String get requiredPassword => 'Senha obrigatória';

  @override
  String get passwordTooLong => 'A senha deve ter no máximo 6 caracteres';

  @override
  String get requiredConfirmPassword => 'Confirmação de senha obrigatória';

  @override
  String get invalidName => 'O nome contém caracteres inválidos';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get fillOnTheContinue => 'Preencha para continuar';

  @override
  String get loginHeadline => 'Acesse sua conta';

  @override
  String get loginDescription => 'Entre com sua conta social ou continue com e-mail para acompanhar candidatos, equipes e oportunidades.';

  @override
  String get loginOptionsTitle => 'Escolha como deseja entrar';

  @override
  String get loginOptionsSubtitle => 'Um fluxo simples, rápido e familiar para começar.';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get continueWithGoogleDescription => 'Use a conta conectada ao seu dispositivo.';

  @override
  String get continueWithFacebook => 'Continuar com Facebook';

  @override
  String get continueWithFacebookDescription => 'Entre com seu perfil social tradicional.';

  @override
  String get orDivider => 'ou';

  @override
  String get continueWithEmail => 'Continuar com e-mail';

  @override
  String get createAccountWithEmail => 'Criar conta com e-mail';

  @override
  String get loginProtectionMessage => 'Seus dados de acesso ficam protegidos e você pode trocar o método de login depois.';

  @override
  String providerComingSoon(String provider) {
    return '$provider será conectado na próxima etapa.';
  }

  @override
  String get emailLoginTitle => 'Login com e-mail';

  @override
  String get emailLoginSubtitle => 'Digite seu e-mail e senha para acessar.';

  @override
  String get signIn => 'Entrar';

  @override
  String get warningTitle => 'Aviso';

  @override
  String get fillAllFields => 'Preencha todos os campos.';

  @override
  String get loginErrorTitle => 'Erro ao entrar';

  @override
  String get registerSuccessTitle => 'Sucesso';

  @override
  String get registerSuccessMessage => 'Conta criada com sucesso!';

  @override
  String get authEmailAlreadyInUse => 'E-mail já cadastrado';

  @override
  String get authInvalidEmail => 'E-mail inválido';

  @override
  String get authGoogleCancelled => 'Login com Google cancelado';

  @override
  String get authFacebookCancelled => 'Login com Facebook cancelado';

  @override
  String get authInvalidCredentials => 'E-mail ou senha inválidos';

  @override
  String get authConfigurationInvalid => 'A configuracao do Firebase deste app esta invalida ou expirada. Atualize a chave da API e o google-services.json do projeto.';

  @override
  String get authGenericFailure => 'Erro na autenticação';
}
