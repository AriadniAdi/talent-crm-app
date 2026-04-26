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
import 'package:talent_crm_app/features/voice/presentation/voices_page.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

import '../../helpers/wrapper.dart';

import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

class MockAudioRecorder extends Mock implements AudioRecorder {}

class MockAudioPlayer extends Mock implements AudioPlayer {}

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

    Get.put<VoiceRepository>(VoiceRepository());
    Get.put<VoiceController>(
      VoiceController(
        recorder: MockAudioRecorder(),
        player: MockAudioPlayer(),
      ),
    );
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

    testWidgets('should render HomeBottomBar', (tester) async {
      controller.allEmployees.add(mockData);
      controller.isLoading.value = false;

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));
        await tester.pump();

        expect(find.byType(HomeBottomBar), findsOneWidget);
      });
    });

    testWidgets('should show Notifications content when selectedIndex is 1',
        (tester) async {
      controller.allEmployees.add(mockData);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));

        controller.selectedIndex.value = 1;
        await tester.pump();

        expect(find.byKey(const Key('notificationsKey')), findsOneWidget);
      });
    });

    testWidgets('should show Voice Notes content when selectedIndex is 2',
        (tester) async {
      controller.allEmployees.add(mockData);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));

        controller.selectedIndex.value = 2;
        await tester.pump();

        expect(find.byType(VoicesPage), findsOneWidget);
      });
    });

    testWidgets('should navigate to home when logo is tapped', (tester) async {
      controller.allEmployees.add(mockData);
      controller.isLoading.value = false;
      controller.selectedIndex.value = 1;

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapper(const HomeShell()));
        await tester.pump();

        await tester.tap(find.byKey(const Key('homeLogoButton')));
        await tester.pump();

        expect(controller.selectedIndex.value, 0);
      });
    });
  });
}
