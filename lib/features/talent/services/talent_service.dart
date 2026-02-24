import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/config/app_config.dart';
import 'package:talent_crm_app/features/talent/model/talent_model.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

class TalentService {
  final String baseUrl;
  final http.Client client;

  const TalentService({
    required this.baseUrl,
    required this.client,
  });

  Future<List<Talent>> fetchTalents() async {
    final response = await client.get(
      AppConfig.uri('/users'),
      headers: AppConfig.defaultHeaders,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load talents');
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw Exception('Invalid response format');
    }

    return decoded
        .map<Talent>((json) => TalentModel.fromJson(json).toEntity())
        .toList();
  }

  Future<Talent> fetchTalentById(int id) async {
    final response = await client.get(
      AppConfig.uri('/users/$id'),
      headers: AppConfig.defaultHeaders,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load talent');
    }

    final json = jsonDecode(response.body);

    return TalentModel.fromJson(json).toEntity();
  }
}
