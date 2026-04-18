import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';
import 'package:talent_crm_app/features/talent/data/repositories/talent_repository_impl.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

class MockTalentRemoteDataSource extends Mock
    implements TalentRemoteDataSource {}

void main() {
  late MockTalentRemoteDataSource mockRemoteDataSource;
  late TalentRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockTalentRemoteDataSource();
    repository = TalentRepositoryImpl(mockRemoteDataSource);
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
    test('should call datasource.fetchTalents once', () async {
      when(() => mockRemoteDataSource.fetchTalents())
          .thenAnswer((_) async => Success([]));

      await repository.getTalents();

      verify(() => mockRemoteDataSource.fetchTalents()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return list of talents from datasource', () async {
      final talents = [jsonTalent];

      when(() => mockRemoteDataSource.fetchTalents())
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

    test('should propagate exception when datasource throws', () async {
      when(() => mockRemoteDataSource.fetchTalents())
          .thenThrow(Exception('Datasource error'));

      expect(
        () => repository.getTalents(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getTalentById', () {
    test('should call datasource.fetchTalentById with correct id', () async {
      when(() => mockRemoteDataSource.fetchTalentById(1))
          .thenAnswer((_) async => Success(jsonTalent));

      await repository.getTalentById(1);

      verify(() => mockRemoteDataSource.fetchTalentById(1)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return talent from datasource', () async {
      when(() => mockRemoteDataSource.fetchTalentById(1))
          .thenAnswer((_) async => Success(jsonTalent));

      final result = await repository.getTalentById(1);

      result.when(
        success: (data) {
          expect(data, equals(mockTalent));
        },
        failure: (AppError error) {},
      );
    });

    test('should propagate exception when datasource throws', () async {
      when(() => mockRemoteDataSource.fetchTalentById(1))
          .thenThrow(Exception('Datasource error'));

      expect(
        () => repository.getTalentById(1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
