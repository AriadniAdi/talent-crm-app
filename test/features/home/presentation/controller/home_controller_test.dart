import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/features/notifications/presentation/controller/notification_controller.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';

import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  late HomeController controller;
  late MockGetTalentsUseCase mockGetTalentsUseCase;

  final mockTalents = List.generate(
    6,
    (i) => Talent(
      id: i + 1,
      name: i == 1 ? 'John doe' : 'User ${i + 1}',
      description: 'Desc ${i + 1}',
      city: 'POA',
      company: 'Company ${i + 1}',
      website: 'site.com',
      contact: ContactTalent(
        email: 'user${i + 1}@mail.com',
        phone: '000${i + 1}',
      ),
    ),
  );

  setUp(() {
    mockGetTalentsUseCase = MockGetTalentsUseCase();
    Get.put<NotificationController>(NotificationController());

    controller = HomeController(
      mockGetTalentsUseCase,
      getRecentTalentsUseCase: const GetRecentTalentsUseCase(),
      searchTalentsUseCase: const SearchTalentsUseCase(),
    );
  });

  group('HomeController - basic actions', () {
    test('changeTab should update selectedIndex', () {
      expect(controller.selectedIndex.value, 0);

      controller.changeTab(2);

      expect(controller.selectedIndex.value, 2);
    });

  });

  group('HomeController - fetchEmployees', () {
    test('should populate employees lists on success', () async {
      when(() => mockGetTalentsUseCase())
          .thenAnswer((_) async => Success(mockTalents));

      await controller.fetchEmployees();

      expect(controller.isLoading.value, false);
      expect(controller.screenError.value, null);

      expect(controller.allEmployees.length, 6);
      expect(controller.allEmployees.first.id, 1);

      expect(controller.recentEmployees.length, 4);
      expect(
          controller.recentEmployees.map((t) => t.id).toList(), [1, 2, 3, 4]);

      verify(() => mockGetTalentsUseCase()).called(1);
      verifyNoMoreInteractions(mockGetTalentsUseCase);
    });

    test('should set error message when usecase throws', () async {
      when(() => mockGetTalentsUseCase())
          .thenAnswer((_) async => Failure(ServerError()));

      await controller.fetchEmployees();

      expect(controller.isLoading.value, false);
      expect(controller.screenError.value, isA<ServerError>());

      expect(controller.allEmployees, isEmpty);
      expect(controller.recentEmployees, isEmpty);

      verify(() => mockGetTalentsUseCase()).called(1);
      verifyNoMoreInteractions(mockGetTalentsUseCase);
    });

    test('should toggle loading during execution', () async {
      when(() => mockGetTalentsUseCase()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 10));
        return Success(mockTalents);
      });

      final future = controller.fetchEmployees();

      expect(controller.isLoading.value, true);

      await future;

      expect(controller.isLoading.value, false);
    });
  });

  group('HomeController - search', () {
    test('should filter allEmployees based on name', () async {
      when(() => mockGetTalentsUseCase())
          .thenAnswer((_) async => Success(mockTalents));
      await controller.fetchEmployees();

      controller.search('John');

      expect(controller.searchQuery.value, 'John');
      expect(controller.allEmployees.length, 1);
      expect(controller.allEmployees.first.name, 'John doe');
    });

    test('should restore full list when query is empty', () async {
      when(() => mockGetTalentsUseCase())
          .thenAnswer((_) async => Success(mockTalents));
      await controller.fetchEmployees();

      controller.search('John');
      expect(controller.allEmployees.length, 1);

      controller.search('');
      expect(controller.searchQuery.value, '');
      expect(controller.allEmployees.length, 6);
    });
  });

  group('HomeController - onInit', () {
    test('should call fetchEmployees on init', () async {
      when(() => mockGetTalentsUseCase())
          .thenAnswer((_) async => Success(mockTalents));

      controller.onInit();

      await Future.delayed(const Duration(milliseconds: 10));

      verify(() => mockGetTalentsUseCase()).called(1);
    });
  });
}
