import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

abstract class TalentRepository {
  Future<List<Talent>> getTalents();
  Future<Talent> getTalentById(int id);
}

class TalentRepositoryImpl implements TalentRepository {
  final TalentService service;

  TalentRepositoryImpl(this.service);

  @override
  Future<List<Talent>> getTalents() async {
    return await service.fetchTalents();
  }

  @override
  Future<Talent> getTalentById(int id) async {
    return await service.fetchTalentById(id);
  }
}
