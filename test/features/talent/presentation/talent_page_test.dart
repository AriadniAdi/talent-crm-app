import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_page.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/talent_header_banner.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/info_card.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/observations_section.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';
import 'package:talent_crm_app/features/voice_recording/presentation/controller/voice_recording_controller.dart';
import '../../helpers/wrapper.dart';

class MockGetTalentsByIdUseCase extends Mock implements GetTalentByIdUseCase {}

void main() {
  late MockGetTalentsByIdUseCase mocktalentId;

  const talent = Talent(
    id: 1,
    name: 'Test User',
    website: 'site.com',
    company: 'company',
    description: '',
    city: '',
    contact: ContactTalent(email: 'test@test.com', phone: '123'),
  );

  setUp(() {
    Get.reset();

    mocktalentId = MockGetTalentsByIdUseCase();

    when(() => mocktalentId.call(any())).thenAnswer(
      (_) async => Success(talent),
    );

    Get.put<TalentController>(TalentController(mocktalentId, 1));
    Get.put<VoiceRecordingController>(VoiceRecordingController());
  });

  testWidgets('renders all sections properly', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const TalentPage(talent: talent),
      ),
    );

    expect(find.byType(TalentHeaderBanner), findsOneWidget);
    expect(find.byType(InfoCard), findsOneWidget);
    expect(find.byType(ObservationsSection), findsOneWidget);
  });

  testWidgets('can render centered content when requested', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const Text('Centered'),
        center: true,
      ),
    );

    expect(find.byType(Center), findsOneWidget);
    expect(find.text('Centered'), findsOneWidget);
  });
}
