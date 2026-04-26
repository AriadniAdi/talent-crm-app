import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';
import 'package:talent_crm_app/features/voice/entities/voice_note.dart';

void main() {
  late VoiceRepository repository;

  setUp(() {
    repository = VoiceRepository();
  });

  test('addVoiceNote adds a note to the list', () {
    final note = VoiceNote(
      id: '1',
      duration: Duration.zero,
      createdAt: DateTime.now(),
      filePath: 'path',
    );

    repository.addVoiceNote(note);

    expect(repository.voiceNotes.length, 1);
    expect(repository.voiceNotes.first, note);
  });

  test('deleteVoiceNote removes a note from the list', () {
    final note = VoiceNote(
      id: '1',
      duration: Duration.zero,
      createdAt: DateTime.now(),
      filePath: 'path',
    );

    repository.addVoiceNote(note);
    repository.deleteVoiceNote('1');

    expect(repository.voiceNotes.isEmpty, true);
  });

  test('getVoiceNotesByTalentId filters notes correctly', () {
    final note1 = VoiceNote(
      id: '1',
      talentId: 'talent1',
      duration: Duration.zero,
      createdAt: DateTime.now(),
      filePath: 'path1',
    );
    final note2 = VoiceNote(
      id: '2',
      talentId: 'talent2',
      duration: Duration.zero,
      createdAt: DateTime.now(),
      filePath: 'path2',
    );

    repository.addVoiceNote(note1);
    repository.addVoiceNote(note2);

    final filtered = repository.getVoiceNotesByTalentId('talent1');
    expect(filtered.length, 1);
    expect(filtered.first.id, '1');
  });
}
