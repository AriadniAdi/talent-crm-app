import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

abstract class TalentRepository {
  Future<List<Talent>> getTalents();
}

class TalentRepositoryImpl implements TalentRepository {
  final TalentService service;

  TalentRepositoryImpl(this.service);

  @override
  Future<List<Talent>> getTalents() async {
    return await service.fetchTalents();
  }
}
