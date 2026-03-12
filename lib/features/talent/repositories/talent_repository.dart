import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/model/talent_model.dart';
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
    final result = await service.fetchTalents();

    return result.when(
      success: (data) {
        final talents =
            data.map((json) => TalentModel.fromJson(json).toEntity()).toList();

        return Success(talents);
      },
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<Talent>> getTalentById(int id) async {
    final result = await service.fetchTalentById(id);

    return result.when(
      success: (data) {
        final talent = TalentModel.fromJson(data).toEntity();
        return Success(talent);
      },
      failure: (error) => Failure(error),
    );
  }
}
