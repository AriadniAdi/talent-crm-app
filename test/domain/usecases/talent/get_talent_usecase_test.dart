import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

class MockTalentRepository extends Mock implements TalentRepository {}

void main() {
  late GetTalentsUseCase useCase;
  late MockTalentRepository mockRepository;

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
    mockRepository = MockTalentRepository();
    useCase = GetTalentsUseCase(mockRepository);
  });

  group('GetTalentsUseCase', () {
    test('should return talents from repository', () async {
      when(() => mockRepository.getTalents())
          .thenAnswer((_) async => Success(mockTalents));

      final result = await useCase();

      expect(result, isA<Success<List<Talent>>>());
      verify(() => mockRepository.getTalents()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should propagate exception when repository throws', () async {
      when(() => mockRepository.getTalents())
          .thenThrow(Exception('Repository error'));

      expect(
        () => useCase(),
        throwsA(isA<Exception>()),
      );

      verify(() => mockRepository.getTalents()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
