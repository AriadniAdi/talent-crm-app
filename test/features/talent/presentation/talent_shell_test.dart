import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_shell.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_page.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';

import '../../helpers/wrapper.dart';

class MockGetTalentByIdUseCase extends Mock implements GetTalentByIdUseCase {}

class MockAudioRecorder extends Mock implements AudioRecorder {}

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late MockGetTalentByIdUseCase mockUseCase;
  late TalentController controller;
  late Talent mockData;

  setUp(() {
    Get.testMode = true;
    mockUseCase = MockGetTalentByIdUseCase();

    mockData = const Talent(
      id: 1,
      name: 'name',
      description: 'description',
      city: 'city',
      company: 'company',
      website: 'website',
      contact: ContactTalent(
        email: 'email',
        phone: 'phone',
      ),
    );

    when(() => mockUseCase(1)).thenAnswer(
      (_) async => Success(mockData),
    );

    Get.put<VoiceRepository>(VoiceRepository());
    controller = TalentController(mockUseCase, 1);
    Get.put<TalentController>(controller);
    Get.put<VoiceController>(
      VoiceController(
        talentId: '1',
        recorder: MockAudioRecorder(),
        player: MockAudioPlayer(),
      ),
      tag: '1',
    );
  });

  tearDown(() {
    Get.reset();
  });

  group('TalentShell', () {
    testWidgets('shows loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(wrapper(const TalentShell()));
      controller.isLoading.value = true;

      await tester.pumpWidget(
        wrapper(const TalentShell()),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows "Talent not found" when talent is null', (tester) async {
      controller.isLoading.value = false;
      controller.talent.value = null;

      await tester.pumpWidget(
        wrapper(const TalentShell()),
      );

      expect(find.byKey(const Key('talent-shell')), findsOneWidget);
    });

    testWidgets('renders TalentPage when talent exists', (tester) async {
      controller.isLoading.value = false;
      controller.talent.value = const Talent(
        id: 1,
        name: 'Test User',
        contact: ContactTalent(email: 'test@email.com', phone: '123'),
        city: 'Porto Alegre',
        company: 'Test Company',
        description: 'description',
        website: 'website',
      );

      await tester.pumpWidget(
        wrapper(const TalentShell()),
      );

      expect(find.byType(TalentPage), findsOneWidget);
    });
  });
}
