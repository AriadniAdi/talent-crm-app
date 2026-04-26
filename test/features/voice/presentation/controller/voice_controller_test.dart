import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';

class MockAudioRecorder extends Mock implements AudioRecorder {}
class MockAudioPlayer extends Mock implements AudioPlayer {}
class FakeRecordConfig extends Fake implements RecordConfig {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRecordConfig());
  });
  // ignore: unused_local_variable
  late VoiceController controller;
  late VoiceRepository repository;
  late MockAudioRecorder mockRecorder;
  late MockAudioPlayer mockPlayer;

  setUp(() {
    repository = VoiceRepository();
    mockRecorder = MockAudioRecorder();
    mockPlayer = MockAudioPlayer();

    Get.put<VoiceRepository>(repository);

    controller = VoiceController(
      talentId: '1',
      recorder: mockRecorder,
      player: mockPlayer,
      documentsDirectoryProvider: () async => Directory.systemTemp,
    );
  });

  tearDown(() {
    Get.reset();
  });

  test('toggleRecording starts recording when not recording', () async {
    when(() => mockRecorder.hasPermission()).thenAnswer((_) async => true);
    when(
      () => mockRecorder.start(any(), path: any(named: 'path')),
    ).thenAnswer((_) async {});

    await controller.toggleRecording();

    expect(controller.isRecording.value, true);
    expect(repository.voiceNotes, isEmpty);
    verify(
      () => mockRecorder.start(any(), path: any(named: 'path')),
    ).called(1);
  });

  test('toggleRecording saves the recording into the shared repository when stopping', () async {
    when(() => mockRecorder.hasPermission()).thenAnswer((_) async => true);
    when(
      () => mockRecorder.start(any(), path: any(named: 'path')),
    ).thenAnswer((_) async {});
    when(() => mockRecorder.stop()).thenAnswer((_) async => '/tmp/voice-note.m4a');

    await controller.toggleRecording();
    await controller.toggleRecording();

    expect(controller.isRecording.value, false);
    expect(repository.voiceNotes, hasLength(1));
    expect(repository.voiceNotes.single.talentId, '1');
    expect(repository.voiceNotes.single.filePath, '/tmp/voice-note.m4a');
  });

  test('voice notes recorded in a talent controller are visible in the shared recordings controller', () async {
    when(() => mockRecorder.hasPermission()).thenAnswer((_) async => true);
    when(
      () => mockRecorder.start(any(), path: any(named: 'path')),
    ).thenAnswer((_) async {});
    when(() => mockRecorder.stop()).thenAnswer((_) async => '/tmp/shared-note.m4a');

    final globalController = VoiceController(
      recorder: mockRecorder,
      player: mockPlayer,
      documentsDirectoryProvider: () async => Directory.systemTemp,
    );

    await controller.toggleRecording();
    await controller.toggleRecording();

    expect(globalController.voiceNotes, hasLength(1));
    expect(globalController.voiceNotes.single.filePath, '/tmp/shared-note.m4a');
  });

  test('toggleRecording exposes an error when microphone permission is denied', () async {
    when(() => mockRecorder.hasPermission()).thenAnswer((_) async => false);

    await controller.toggleRecording();

    expect(controller.isRecording.value, false);
    expect(controller.audioError.value, isA<MessageError>());
  });
}
