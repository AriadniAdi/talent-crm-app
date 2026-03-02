import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/core/widgets/error_state_widget.dart';

import 'package:talent_crm_app/features/home/presentation/home_shell.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

import '../../helpers/wrapper.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  late MockGetTalentsUseCase mockUseCase;
  late HomeController controller;
  late Talent mockData;

  setUp(() {
    Get.reset();
    Get.testMode = true;

    mockUseCase = MockGetTalentsUseCase();
    when(() => mockUseCase()).thenAnswer(
      (_) async => Success(<Talent>[]),
    );

    controller = HomeController(mockUseCase);

    setupTestDependencies<HomeController>(mockController: controller);

    mockData = const Talent(
      id: 1,
      name: 'Test User',
      website: 'site.com',
      company: 'company',
      description: '',
      city: '',
      contact: ContactTalent(email: 'test@test.com', phone: '123'),
    );
  });

  tearDown(() {
    Get.reset();
  });

  group('HomeShell States', () {
    testWidgets(
        'should render CircularProgressIndicator when isLoading is true',
        (tester) async {
      controller.isLoading.value = true;

      await tester.pumpWidget(wrapper(const HomeShell()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'should render ErrorStateWidget when there is a screen error and no employees',
        (tester) async {
      controller.isLoading.value = false;
      controller.allEmployees.clear();
      controller.screenError.value = NetworkError();

      await tester.pumpWidget(wrapper(const HomeShell()));
      await tester.pump();

      expect(find.byType(ErrorStateWidget), findsOneWidget);
    });
  });

  group('HomeShell Navigation', () {
    testWidgets('should render HomePage when selectedIndex is 0',
        (tester) async {
      controller.allEmployees.add(mockData);
      controller.isLoading.value = false;

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));
        await tester.pump();

        expect(find.byType(HomePage), findsOneWidget);
      });
    });

    testWidgets('should show Teams content when selectedIndex is 1',
        (tester) async {
      controller.allEmployees.add(mockData);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));

        controller.selectedIndex.value = 1;
        await tester.pump();

        expect(find.byKey(const Key('teamsKey')), findsOneWidget);
      });
    });

    testWidgets('should show Notifications content when selectedIndex is 2',
        (tester) async {
      controller.allEmployees.add(mockData);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));

        controller.selectedIndex.value = 2;
        await tester.pump();

        expect(find.byKey(const Key('notificationsKey')), findsOneWidget);
      });
    });

    testWidgets('should show Voice Notes content when selectedIndex is 3',
        (tester) async {
      controller.allEmployees.add(mockData);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));

        controller.selectedIndex.value = 3;
        await tester.pump();

        expect(find.byKey(const Key('voiceNotesKey')), findsOneWidget);
      });
    });
  });
}
