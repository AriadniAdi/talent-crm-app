import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';
import 'package:talent_crm_app/features/talent/data/repositories/talent_repository_impl.dart';

class MockTalentRemoteDataSource extends Mock
    implements TalentRemoteDataSource {}

void main() {
  late TalentRepositoryImpl repository;
  late MockTalentRemoteDataSource mockRemoteDataSource;

  final mockTalentJson = [
    {
      "id": 1,
      "name": "John",
      "email": "john@email.com",
      "phone": "9999",
      "website": "site.com",
      "address": {"city": "POA"},
      "company": {"name": "Tech Corp", "catchPhrase": "Developer"}
    },
    {
      "id": 2,
      "name": "Adi",
      "email": "adi@email.com",
      "phone": "51999999999",
      "website": "adi.dev",
      "address": {"city": "Porto Alegre"},
      "company": {"name": "Talent CRM", "catchPhrase": "Flutter Dev"}
    }
  ];

  setUp(() {
    mockRemoteDataSource = MockTalentRemoteDataSource();
    repository = TalentRepositoryImpl(mockRemoteDataSource);
  });

  group('TalentRepositoryImpl.getTalents', () {
    test('should return list of talents when datasource succeeds', () async {
      when(() => mockRemoteDataSource.fetchTalents())
          .thenAnswer((_) async => Success(mockTalentJson));

      final result = await repository.getTalents();

      result.when(
        success: (data) {
          expect(data.length, 2);

          final first = data[0];
          final second = data[1];

          expect(first.name, 'John');
          expect(first.company, 'Tech Corp');
          expect(first.website, 'site.com');

          expect(second.name, 'Adi');
          expect(second.company, 'Talent CRM');
          expect(second.website, 'adi.dev');
        },
        failure: (_) => fail('Expected success'),
      );

      verify(() => mockRemoteDataSource.fetchTalents()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should propagate exception when datasource throws', () async {
      when(() => mockRemoteDataSource.fetchTalents())
          .thenThrow(Exception('Network error'));

      expect(
        () => repository.getTalents(),
        throwsA(isA<Exception>()),
      );

      verify(() => mockRemoteDataSource.fetchTalents()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
