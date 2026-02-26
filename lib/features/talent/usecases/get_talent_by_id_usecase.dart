import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';

class GetTalentByIdUseCase {
  final TalentRepository repository;

  GetTalentByIdUseCase(this.repository);

  Future<Talent> call(int id) async {
    return await repository.getTalentById(id);
  }
}
