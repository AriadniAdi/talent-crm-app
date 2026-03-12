import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

class MockTalentService extends Mock implements TalentService {}

void main() {
  late MockTalentService mockService;
  late TalentRepositoryImpl repository;

  setUp(() {
    mockService = MockTalentService();
    repository = TalentRepositoryImpl(mockService);
  });

  const mockTalent = Talent(
    id: 1,
    name: 'Test User',
    website: 'site.com',
    company: 'company',
    description: 'description',
    city: 'city',
    contact: ContactTalent(email: 'test@test.com', phone: '123'),
  );

  final jsonTalent = {
    "id": 1,
    "name": "Test User",
    "email": "test@test.com",
    "phone": "123",
    "website": "site.com",
    "address": {"city": "city"},
    "company": {"name": "company", "catchPhrase": "description"}
  };

  group('getTalents', () {
    test('should call service.fetchTalents once', () async {
      when(() => mockService.fetchTalents())
          .thenAnswer((_) async => Success([]));

      await repository.getTalents();

      verify(() => mockService.fetchTalents()).called(1);
      verifyNoMoreInteractions(mockService);
    });

    test('should return list of talents from service', () async {
      final talents = [jsonTalent];

      when(() => mockService.fetchTalents())
          .thenAnswer((_) async => Success(talents));

      final result = await repository.getTalents();

      result.when(
        success: (data) {
          expect(data.length, 1);

          final talent = data.first;

          expect(talent.name, 'Test User');
          expect(talent.city, 'city');
          expect(talent.company, 'company');
          expect(talent.description, 'description');
          expect(talent.website, 'site.com');
          expect(talent.contact.email, 'test@test.com');
          expect(talent.contact.phone, '123');
        },
        failure: (_) => fail('Expected success'),
      );
    });

    test('should propagate exception when service throws', () async {
      when(() => mockService.fetchTalents())
          .thenThrow(Exception('Service error'));

      expect(
        () => repository.getTalents(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getTalentById', () {
    test('should call service.fetchTalentById with correct id', () async {
      when(() => mockService.fetchTalentById(1))
          .thenAnswer((_) async => Success(jsonTalent));

      await repository.getTalentById(1);

      verify(() => mockService.fetchTalentById(1)).called(1);
      verifyNoMoreInteractions(mockService);
    });

    test('should return talent from service', () async {
      when(() => mockService.fetchTalentById(1))
          .thenAnswer((_) async => Success(jsonTalent));

      final result = await repository.getTalentById(1);

      result.when(
        success: (data) {
          expect(data, equals(mockTalent));
        },
        failure: (AppError error) {},
      );
    });

    test('should propagate exception when service throws', () async {
      when(() => mockService.fetchTalentById(1))
          .thenThrow(Exception('Service error'));

      expect(
        () => repository.getTalentById(1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
