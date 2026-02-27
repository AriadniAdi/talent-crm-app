import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

class MockTalentRepository extends Mock implements TalentRepository {}

void main() {
  late MockTalentRepository mockRepository;
  late GetTalentsUseCase useCase;

  setUp(() {
    mockRepository = MockTalentRepository();
    useCase = GetTalentsUseCase(mockRepository);
  });

  final talents = [
    const Talent(
      id: 1,
      name: 'Test Name',
      contact: ContactTalent(email: 'test@email.com', phone: '123'),
      website: 'site.com',
      company: 'company',
      description: '',
      city: '',
    ),
  ];

  group('GetTalentsUseCase', () {
    test('should call repository.getTalents once', () async {
      when(() => mockRepository.getTalents())
          .thenAnswer((_) async => Success([]));

      await useCase();

      verify(() => mockRepository.getTalents()).called(1);
    });

    test('should return list of talents from repository', () async {
      when(() => mockRepository.getTalents())
          .thenAnswer((_) async => Success(talents));

      final result = await useCase();

      result.when(
        success: (data) {
          expect(data, equals(talents));
        },
        failure: (_) => fail('Expected success'),
      );
    });

    test('should propagate exception when repository throws', () async {
      when(() => mockRepository.getTalents())
          .thenThrow(Exception('Repository error'));

      expect(
        () => useCase(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
