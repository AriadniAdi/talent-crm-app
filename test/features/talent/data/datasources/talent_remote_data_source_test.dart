import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:talent_crm_app/core/config/app_config.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockClient;
  late TalentRemoteDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockHttpClient();
    dataSource = TalentRemoteDataSourceImpl(
      apiClient: ApiClient(mockClient),
    );
  });

  group('fetchTalents', () {
    final mockListResponse = [
      {
        "id": 1,
        "name": "Leanne Graham",
        "username": "Bret",
        "email": "test@test.com",
        "phone": "123",
        "website": "site.com",
        "company": null,
        "address": null,
      }
    ];

    test('should return list of json when status is 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(mockListResponse), 200),
      );

      final result = await dataSource.fetchTalents();

      result.when(
        success: (data) {
          expect(data.length, 1);
          expect(data, isA<List<Map<String, dynamic>>>());

          final user = data.first;

          expect(user['name'], 'Leanne Graham');
          expect(user['email'], 'test@test.com');
          expect(user['phone'], '123');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should return Failure when status is not 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      final result = await dataSource.fetchTalents();
      expect(result, isA<Failure<List<Map<String, dynamic>>>>());
    });

    test('should return Failure when response is not a list', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode({"invalid": "data"}), 200),
      );

      final result = await dataSource.fetchTalents();

      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ParsingError>());
        },
      );
    });
  });

  group('fetchTalentById', () {
    final mockResponse = {
      "id": 1,
      "name": "Leanne Graham",
      "username": "Bret",
      "email": "test@test.com",
      "phone": "123",
      "website": "site.com",
      "company": null,
      "address": null,
    };

    test('should call correct endpoint with id', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(mockResponse), 200),
      );

      await dataSource.fetchTalentById(1);

      verify(() => mockClient.get(
            AppConfig.uri('/users/1'),
            headers: any(named: 'headers'),
          )).called(1);
    });

    test('should return json object when status is 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(mockResponse), 200),
      );

      final result = await dataSource.fetchTalentById(1);

      result.when(
        success: (data) {
          expect(data, isA<Map<String, dynamic>>());
          expect(data['name'], 'Leanne Graham');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should return Failure when status is not 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      final result = await dataSource.fetchTalentById(1);

      expect(result, isA<Failure<Map<String, dynamic>>>());
    });
  });
}
