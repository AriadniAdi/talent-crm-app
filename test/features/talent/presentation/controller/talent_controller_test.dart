import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:talent_crm_app/core/config/app_config.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockClient;
  late TalentService service;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockHttpClient();
    service = TalentService(
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

    test('should call correct endpoint with headers', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(mockListResponse), 200),
      );

      await service.fetchTalents();

      verify(() => mockClient.get(
            AppConfig.uri('/users'),
            headers: AppConfig.defaultHeaders,
          )).called(1);
    });

    test('should return list of Talent when status is 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(mockListResponse), 200),
      );

      final result = await service.fetchTalents();

      result.when(
        success: (data) {
          expect(data, isA<List<Talent>>());
          expect(data.length, 1);
          expect(data.first.name, 'Leanne Graham');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should throw exception when status is not 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      final result = await service.fetchTalents();
      expect(result, isA<Failure<List<Talent>>>());
    });

    test('should throw exception when response is not a list', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode({"invalid": "data"}), 200),
      );

      final result = await service.fetchTalents();

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

      await service.fetchTalentById(1);

      verify(() => mockClient.get(
            AppConfig.uri('/users/1'),
            headers: AppConfig.defaultHeaders,
          )).called(1);
    });

    test('should return Talent when status is 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(mockResponse), 200),
      );

      final result = await service.fetchTalentById(1);

      result.when(
        success: (data) {
          expect(data, isA<Talent>());
          expect(data.name, 'Leanne Graham');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should throw exception when status is not 200', () async {
      when(() => mockClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      final result = await service.fetchTalentById(1);

      expect(result, isA<Failure<Talent>>());
    });
  });
}
