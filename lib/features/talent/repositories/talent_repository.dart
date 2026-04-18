import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

abstract class TalentRepository {
  Future<Result<List<Talent>>> getTalents();
  Future<Result<Talent>> getTalentById(int id);
}
