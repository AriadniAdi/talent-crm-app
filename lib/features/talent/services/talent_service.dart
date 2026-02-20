import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/features/talent/model/talent_model.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

class TalentService {
  final http.Client client;

  TalentService(this.client);

  Future<List<Talent>> fetchTalents() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {
        'User-Agent': 'Mozilla/5.0',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception('Invalid response format');
      }

      return decoded
          .map((json) => TalentModel.fromJson(json).toEntity())
          .toList();
    }

    throw Exception('Failed to load talents');
  }
}
