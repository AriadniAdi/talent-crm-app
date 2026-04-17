import 'package:talent_crm_app/core/config/app_config.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/core/result/result.dart';

class TalentRemoteDataSource {
  final ApiClient apiClient;

  const TalentRemoteDataSource({
    required this.apiClient,
  });

  Future<Result<List<Map<String, dynamic>>>> fetchTalents() async {
    final result = await apiClient.get(AppConfig.uri('/users'));

    return result.when(
      success: (data) {
        if (data is! List) {
          return Failure(ParsingError());
        }

        return Success(
          data.map((e) => e as Map<String, dynamic>).toList(),
        );
      },
      failure: (error) => Failure(error),
    );
  }

  Future<Result<Map<String, dynamic>>> fetchTalentById(int id) async {
    final uri = AppConfig.uri('/users/$id');

    final result = await apiClient.get(uri);

    return result.when(
      success: (data) {
        if (data is! Map<String, dynamic>) {
          return Failure(ParsingError());
        }

        return Success(data);
      },
      failure: (error) => Failure(error),
    );
  }
}
