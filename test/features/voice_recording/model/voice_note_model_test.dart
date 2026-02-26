import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';

void main() {
  group('VoiceNoteModel', () {
    final now = DateTime(2024, 1, 1);

    test('creates instance correctly', () {
      final model = VoiceNoteModel(
        id: '1',
        duration: const Duration(minutes: 1, seconds: 30),
        createdAt: now,
        filePath: '/path/audio.aac',
      );

      expect(model.id, '1');
      expect(model.duration, const Duration(minutes: 1, seconds: 30));
      expect(model.createdAt, now);
      expect(model.filePath, '/path/audio.aac');
    });

    test('formats duration correctly (01:30)', () {
      final model = VoiceNoteModel(
        id: '1',
        duration: const Duration(minutes: 1, seconds: 30),
        createdAt: now,
        filePath: '',
      );

      expect(model.durationFormatted, '01:30');
    });

    test('formats duration with leading zeros (00:05)', () {
      final model = VoiceNoteModel(
        id: '1',
        duration: const Duration(seconds: 5),
        createdAt: now,
        filePath: '',
      );

      expect(model.durationFormatted, '00:05');
    });

    test('formats duration greater than 9 minutes (12:07)', () {
      final model = VoiceNoteModel(
        id: '1',
        duration: const Duration(minutes: 12, seconds: 7),
        createdAt: now,
        filePath: '',
      );

      expect(model.durationFormatted, '12:07');
    });

    test('formats zero duration (00:00)', () {
      final model = VoiceNoteModel(
        id: '1',
        duration: Duration.zero,
        createdAt: now,
        filePath: '',
      );

      expect(model.durationFormatted, '00:00');
    });
  });
}
