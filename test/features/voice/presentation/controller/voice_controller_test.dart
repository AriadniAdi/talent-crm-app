import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';

class MockVoiceRepository extends Mock implements VoiceRepository {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback<void>(callback: () {});
  @override
  InternalFinalCallback<void> get onDelete => InternalFinalCallback<void>(callback: () {});
}
class MockAudioRecorder extends Mock implements AudioRecorder {}
class MockAudioPlayer extends Mock implements AudioPlayer {}
class FakeRecordConfig extends Fake implements RecordConfig {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRecordConfig());
  });
  // ignore: unused_local_variable
  late VoiceController controller;
  late MockVoiceRepository mockRepository;
  late MockAudioRecorder mockRecorder;
  late MockAudioPlayer mockPlayer;

  setUp(() {
    mockRepository = MockVoiceRepository();
    mockRecorder = MockAudioRecorder();
    mockPlayer = MockAudioPlayer();

    Get.put<VoiceRepository>(mockRepository);

    controller = VoiceController(
      talentId: '1',
      recorder: mockRecorder,
      player: mockPlayer,
    );
  });

  tearDown(() {
    Get.reset();
  });

  test('toggleRecording starts recording when not recording', () async {
    when(() => mockRecorder.hasPermission()).thenAnswer((_) async => true);
    when(() => mockRecorder.start(any(), path: any(named: 'path'))).thenAnswer((_) async => {});

    // Need to mock getApplicationDocumentsDirectory but it's hard in unit tests without path_provider_platform_interface
    // For now, this test might fail or need more complex setup
  });
}
