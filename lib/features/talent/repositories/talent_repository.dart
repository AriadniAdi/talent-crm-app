import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

abstract class TalentRepository {
  Future<Result<List<Talent>>> getTalents();
  Future<Result<Talent>> getTalentById(int id);
}

class TalentRepositoryImpl implements TalentRepository {
  final TalentService service;

  TalentRepositoryImpl(this.service);

  @override
  Future<Result<List<Talent>>> getTalents() async {
    return await service.fetchTalents();
  }

  @override
  Future<Result<Talent>> getTalentById(int id) async {
    return await service.fetchTalentById(id);
  }
}
