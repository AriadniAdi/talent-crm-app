import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/model/talent_model.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';

class TalentRepositoryImpl implements TalentRepository {
  final TalentRemoteDataSource dataSource;

  TalentRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<Talent>>> getTalents() async {
    final result = await dataSource.fetchTalents();

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
    final result = await dataSource.fetchTalentById(id);

    return result.when(
      success: (data) {
        final talent = TalentModel.fromJson(data).toEntity();
        return Success(talent);
      },
      failure: (error) => Failure(error),
    );
  }
}
