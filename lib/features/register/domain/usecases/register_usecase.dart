import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_contract.dart';

class RegisterUseCase implements RegisterContract {
  final AuthRepository authRepository;

  const RegisterUseCase(this.authRepository);

  @override
  Future<void> call(RegisterParams params) async {
    final result = await authRepository.registerUser(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
      countryCode: params.countryCode,
      cpf: params.cpf,
      birthDate: params.birthDate,
    );

    switch (result) {
      case Success<bool>():
        return;
      case Failure<bool>(error: final error):
        throw error;
    }
  }
}
