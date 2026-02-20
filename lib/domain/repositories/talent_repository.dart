import 'package:talent_crm_app/data/services/talent/talent_service.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';

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
