import 'package:talent_crm_app/domain/entities/talent/talent.dart';
import 'package:talent_crm_app/domain/repositories/talent_repository.dart';

class GetTalentsUseCase {
  final TalentRepository repository;

  GetTalentsUseCase(this.repository);

  Future<List<Talent>> call() async {
    return await repository.getTalents();
  }
}
