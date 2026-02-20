import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/data/models/talent_model.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';

class TalentService {
  final http.Client client;

  TalentService(this.client);

  Future<List<Talent>> fetchTalents() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);

      return decoded
          .map((json) => TalentModel.fromJson(json).toEntity())
          .toList();
    } else {
      throw Exception('Failed to load talents');
    }
  }
}
