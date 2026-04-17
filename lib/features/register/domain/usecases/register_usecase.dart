import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';

class RegisterUseCase {
  const RegisterUseCase();

  Future<void> call(RegisterParams params) async {
    if (params.name.isEmpty) {
      throw AuthError('Nome obrigatório');
    }

    if (!GetUtils.isEmail(params.email)) {
      throw AuthError('E-mail inválido');
    }

    if (params.password.length < 6) {
      throw AuthError('Senha muito curta');
    }

    await Future.delayed(const Duration(milliseconds: 800));
  }
}
