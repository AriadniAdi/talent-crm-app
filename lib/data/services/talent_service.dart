import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/data/models/talent_model.dart';

class TalentService {
  final http.Client client;

  TalentService(this.client);

  Future<List<TalentModel>> fetchTalents() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((json) => TalentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load talents');
    }
  }
}
