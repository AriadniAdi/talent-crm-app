import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  static const Map<String, String> _defaultHeaders = {
    'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X)',
    'Accept': 'application/json',
    'Accept-Language': 'en-US,en;q=0.9',
    'Connection': 'keep-alive',
  };

  Future<Result<dynamic>> get(Uri uri) async {
    try {
      final response = await client.get(
        uri,
        headers: _defaultHeaders,
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        return Success(jsonDecode(response.body));
      }

      if (statusCode == 404) {
        return Failure(NotFoundError());
      }

      if (statusCode >= 500) {
        return Failure(ServerError());
      }

      if (statusCode >= 400) {
        return Failure(ServerError());
      }

      return Failure(UnknownError());
    } on http.ClientException {
      return Failure(NetworkError());
    } on FormatException {
      return Failure(ParsingError());
    } catch (_) {
      return Failure(UnknownError());
    }
  }
}
