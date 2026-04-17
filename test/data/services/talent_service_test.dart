import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late TalentRemoteDataSource remoteDataSource;
  late MockHttpClient mockClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockClient = MockHttpClient();
    remoteDataSource = TalentRemoteDataSource(
      apiClient: ApiClient(mockClient),
    );
  });

  const mockResponse = [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@email.com",
      "website": "johndoe.com",
      "phone": "9999",
      "address": {"city": "Porto Alegre"},
      "company": {"name": "Tech Corp", "catchPhrase": "Innovation first"}
    }
  ];

  test('should return list of TalentModel when request is successful',
      () async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response(jsonEncode(mockResponse), 200),
    );

    final result = await remoteDataSource.fetchTalents();

    result.when(
      success: (data) {
        expect(data.length, 1);
        expect(data.first['name'], "John Doe");
        expect(data.first['address']['city'], "Porto Alegre");
      },
      failure: (_) {
        fail('Expected success but got failure');
      },
    );
  });

  test('should return Failure when response body is invalid JSON', () async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response('invalid-json', 200),
    );

    final result = await remoteDataSource.fetchTalents();

    result.when(
      success: (_) => fail('Expected failure'),
      failure: (error) {
        expect(error, isA<ParsingError>());
      },
    );
  });

  test('should return empty list when response is empty', () async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response('Error', 500),
    );

    final result = await remoteDataSource.fetchTalents();

    expect(result, isA<Failure<List<Map<String, dynamic>>>>());
  });

  test('should return Failure when response is not a list', () async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response(jsonEncode({"error": "unexpected"}), 200),
    );

    final result = await remoteDataSource.fetchTalents();

    result.when(
      success: (_) => fail('Expected failure'),
      failure: (error) {
        expect(error, isA<ParsingError>());
      },
    );
  });

  test('should return Failure when http client throws', () async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenThrow(http.ClientException('Network error'));

    final result = await remoteDataSource.fetchTalents();

    result.when(
      success: (_) => fail('Expected failure'),
      failure: (error) {
        expect(error, isA<NetworkError>());
      },
    );
  });

  test('should call correct endpoint', () async {
    when(() => mockClient.get(
          any(),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => http.Response(jsonEncode(mockResponse), 200),
    );

    await remoteDataSource.fetchTalents();

    final captured = verify(() => mockClient.get(
          captureAny(),
          headers: captureAny(named: 'headers'),
        )).captured;

    final Uri calledUri = captured[0];

    expect(
      calledUri.toString(),
      'https://jsonplaceholder.typicode.com/users',
    );
  });
}
