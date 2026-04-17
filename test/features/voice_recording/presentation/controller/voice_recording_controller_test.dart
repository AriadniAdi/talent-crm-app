import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';
import 'package:talent_crm_app/features/voice_recording/presentation/controller/voice_recording_controller.dart';

void main() {
  late VoiceRecordingController controller;

  setUp(() {
    controller = VoiceRecordingController();
  });

  group('VoiceRecordingController', () {
    test('starts and stops recording while creating a note', () async {
      expect(controller.isRecording.value, false);
      expect(controller.voiceNotes, isEmpty);

      await controller.toggleRecording();
      expect(controller.isRecording.value, true);

      await controller.toggleRecording();
      expect(controller.isRecording.value, false);
      expect(controller.voiceNotes, hasLength(1));
    });

    test('toggles play state for a note', () {
      final note = VoiceNoteModel(
        id: '1',
        duration: const Duration(seconds: 10),
        filePath: '',
        createdAt: DateTime(2026),
      );

      controller.togglePlay(note);
      expect(controller.isPlayingId.value, '1');

      controller.togglePlay(note);
      expect(controller.isPlayingId.value, isNull);
    });

    test('deletes note and clears playing id', () {
      final note = VoiceNoteModel(
        id: '1',
        duration: const Duration(seconds: 10),
        filePath: '',
        createdAt: DateTime(2026),
      );

      controller.voiceNotes.add(note);
      controller.isPlayingId.value = note.id;

      controller.deleteNote(note.id);

      expect(controller.voiceNotes, isEmpty);
      expect(controller.isPlayingId.value, isNull);
    });
  });
}
