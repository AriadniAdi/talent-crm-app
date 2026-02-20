import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';

class GetTalentsUseCase {
  final TalentRepository repository;

  GetTalentsUseCase(this.repository);

  Future<List<Talent>> call() async {
    return await repository.getTalents();
  }
}
