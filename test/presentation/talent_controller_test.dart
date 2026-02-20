import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_controller.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  late TalentController controller;
  late MockGetTalentsUseCase mockUseCase;

  final mockTalents = [
    const Talent(
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
    ),
  ];

  setUp(() {
    mockUseCase = MockGetTalentsUseCase();
    controller = TalentController(mockUseCase);
  });

  group('TalentController - fetchTalents', () {
    test('should populate talents on success', () async {
      when(() => mockUseCase()).thenAnswer((_) async => mockTalents);

      await controller.fetchTalents();

      expect(controller.isLoading.value, false);
      expect(controller.error.value, null);
      expect(controller.talents, mockTalents);

      verify(() => mockUseCase()).called(1);
      verifyNoMoreInteractions(mockUseCase);
    });

    test('should set error when usecase throws', () async {
      when(() => mockUseCase()).thenThrow(Exception('UseCase failure'));

      await controller.fetchTalents();

      expect(controller.isLoading.value, false);
      expect(controller.talents, isEmpty);
      expect(controller.error.value, contains('UseCase failure'));

      verify(() => mockUseCase()).called(1);
      verifyNoMoreInteractions(mockUseCase);
    });

    test('should toggle loading correctly during execution', () async {
      when(() => mockUseCase()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 10));
        return mockTalents;
      });

      final future = controller.fetchTalents();

      expect(controller.isLoading.value, true);

      await future;

      expect(controller.isLoading.value, false);
    });
  });

  group('onInit', () {
    test('should call fetchTalents on init', () async {
      when(() => mockUseCase()).thenAnswer((_) async => mockTalents);

      controller.onInit();

      await Future.delayed(const Duration(milliseconds: 10));

      verify(() => mockUseCase()).called(1);
    });
  });
}
