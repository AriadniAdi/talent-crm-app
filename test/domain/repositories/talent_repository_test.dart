import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/data/services/talent/talent_service.dart';
import 'package:talent_crm_app/domain/entities/talent/contact_talent.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';
import 'package:talent_crm_app/domain/repositories/talent_repository.dart';

class MockTalentService extends Mock implements TalentService {}

void main() {
  late TalentRepositoryImpl repository;
  late MockTalentService mockService;

  final mockTalents = [
    const Talent(
      id: 1,
      name: 'John',
      description: 'Developer',
      city: 'POA',
      company: 'Tech Corp',
      website: 'site.com',
      contact: ContactTalent(
        email: 'john@email.com',
        phone: '9999',
      ),
    ),
    const Talent(
      id: 2,
      name: 'Adi',
      description: 'Flutter Dev',
      city: 'Porto Alegre',
      company: 'Talent CRM',
      website: 'adi.dev',
      contact: ContactTalent(
        email: 'adi@email.com',
        phone: '51999999999',
      ),
    ),
  ];

  setUp(() {
    mockService = MockTalentService();
    repository = TalentRepositoryImpl(mockService);
  });

  group('TalentRepositoryImpl.getTalents', () {
    test('should return list of talents when service succeeds', () async {
      when(() => mockService.fetchTalents())
          .thenAnswer((_) async => mockTalents);

      final result = await repository.getTalents();

      expect(result, mockTalents);
      verify(() => mockService.fetchTalents()).called(1);
      verifyNoMoreInteractions(mockService);
    });

    test('should propagate exception when service throws', () async {
      when(() => mockService.fetchTalents())
          .thenThrow(Exception('Network error'));

      expect(
        () => repository.getTalents(),
        throwsA(isA<Exception>()),
      );

      verify(() => mockService.fetchTalents()).called(1);
      verifyNoMoreInteractions(mockService);
    });
  });
}
