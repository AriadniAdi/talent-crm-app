import 'package:talent_crm_app/core/config/app_config.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/model/talent_model.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

class TalentService {
  final ApiClient apiClient;

  const TalentService({
    required this.apiClient,
  });

  Future<Result<List<Talent>>> fetchTalents() async {
    final result = await apiClient.get(AppConfig.uri('/users'));
    return result.when(
        success: (data) {
          if (data is! List) {
            return Failure(ParsingError());
          }
          final talents = data
              .map<Talent>((json) => TalentModel.fromJson(json).toEntity())
              .toList();

          return Success(talents);
        },
        failure: (error) => Failure(error));
  }

  Future<Result<Talent>> fetchTalentById(int id) async {
    final uri = AppConfig.uri('/users/$id');

    final result = await apiClient.get(uri);

    return result.when(
      success: (data) {
        if (data is! Map<String, dynamic>) {
          return Failure(ParsingError());
        }

        return Success(
          TalentModel.fromJson(data).toEntity(),
        );
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }
}
