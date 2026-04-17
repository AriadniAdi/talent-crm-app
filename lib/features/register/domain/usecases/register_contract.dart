import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';

abstract class RegisterContract {
  Future<void> call(RegisterParams params);
}
