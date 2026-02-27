import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';

class MockTalentRepository extends Mock implements TalentRepository {}

void main() {
  late MockTalentRepository mockRepository;
  late GetTalentByIdUseCase useCase;

  setUp(() {
    mockRepository = MockTalentRepository();
    useCase = GetTalentByIdUseCase(mockRepository);
  });

  const mockTalent = Talent(
      id: 1,
      name: 'Test User',
      website: 'site.com',
      company: 'company',
      contact: ContactTalent(email: 'test@test.com', phone: '123'),
      description: 'description',
      city: 'city');

  group('GetTalentByIdUseCase', () {
    test('should call repository.getTalentById with correct id', () async {
      when(() => mockRepository.getTalentById(1))
          .thenAnswer((_) async => Success(mockTalent));

      await useCase(1);

      verify(() => mockRepository.getTalentById(1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository fails', () async {
      when(() => mockRepository.getTalentById(1))
          .thenAnswer((_) async => Failure(ServerError()));

      final result = await useCase(1);

      result.when(
        success: (_) => fail('Expected failure'),
        failure: (error) {
          expect(error, isA<ServerError>());
        },
      );
    });
  });
}
