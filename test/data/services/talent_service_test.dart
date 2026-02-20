import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/data/services/talent/talent_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late TalentService service;
  late MockHttpClient mockClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockClient = MockHttpClient();
    service = TalentService(mockClient);
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
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(jsonEncode(mockResponse), 200),
    );

    final result = await service.fetchTalents();

    expect(result.length, 1);
    expect(result.first.name, "John Doe");
    expect(result.first.city, "Porto Alegre");
  });

  test('should throw exception when status code is not 200', () async {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response('Error', 500),
    );

    expect(
      () => service.fetchTalents(),
      throwsException,
    );
  });

  test('should return empty list when response is empty', () async {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(jsonEncode([]), 200),
    );

    final result = await service.fetchTalents();

    expect(result, isEmpty);
  });

  test('should throw exception when response body is invalid JSON', () async {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response('invalid-json', 200),
    );

    expect(
      () => service.fetchTalents(),
      throwsA(isA<FormatException>()),
    );
  });

  test('should throw exception when response is not a list', () async {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(jsonEncode({"error": "unexpected"}), 200),
    );

    expect(
      () => service.fetchTalents(),
      throwsException,
    );
  });

  test('should throw exception when http client fails', () async {
    when(() => mockClient.get(any())).thenThrow(Exception('Network error'));

    expect(
      () => service.fetchTalents(),
      throwsException,
    );
  });

  test('should call correct endpoint', () async {
    when(() => mockClient.get(
          any(),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => http.Response(jsonEncode(mockResponse), 200),
    );

    await service.fetchTalents();

    verify(() => mockClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users'),
          headers: {
            'User-Agent': 'Mozilla/5.0',
            'Accept': 'application/json',
          },
        )).called(1);
  });
}
