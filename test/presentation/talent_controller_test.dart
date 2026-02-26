import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';

class MockGetTalentsByIdUseCase extends Mock implements GetTalentByIdUseCase {}

void main() {
  late TalentController controller;
  late MockGetTalentsByIdUseCase mockUseCase;

  const mockTalent = Talent(
    id: 1,
    name: 'John',
    description: 'Developer',
    city: 'POA',
    company: 'Tech',
    website: 'site.com',
    contact: ContactTalent(
      email: 'john@email.com',
      phone: '9999',
    ),
  );

  setUp(() {
    mockUseCase = MockGetTalentsByIdUseCase();
    controller = TalentController(mockUseCase, 1);
  });

  group('TalentController - fetchTalents', () {
    test('should populate talents on success', () async {
      when(() => mockUseCase(1)).thenAnswer((_) async => mockTalent);

      await controller.fetchTalent();

      expect(controller.isLoading.value, false);
      expect(controller.error.value, null);
      expect(controller.talent.value, mockTalent);

      verify(() => mockUseCase(1)).called(1);
      verifyNoMoreInteractions(mockUseCase);
    });

    test('should set error when usecase throws', () async {
      when(() => mockUseCase(1)).thenThrow(Exception('UseCase failure'));

      await controller.fetchTalent();

      expect(controller.isLoading.value, false);
      expect(controller.talent.value, isNull);
      expect(controller.error.value, contains('UseCase failure'));

      verify(() => mockUseCase(1)).called(1);
      verifyNoMoreInteractions(mockUseCase);
    });

    test('should toggle loading correctly during execution', () async {
      when(() => mockUseCase(1)).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 10));
        return mockTalent;
      });

      final future = controller.fetchTalent();

      expect(controller.isLoading.value, true);

      await future;

      expect(controller.isLoading.value, false);
    });
  });

  group('onInit', () {
    test('should call fetchTalents on init', () async {
      when(() => mockUseCase(1)).thenAnswer((_) async => mockTalent);

      controller.onInit();

      await Future.delayed(const Duration(milliseconds: 10));

      verify(() => mockUseCase(1)).called(1);
    });
  });
}
