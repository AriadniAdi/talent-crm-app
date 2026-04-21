import 'package:get/get.dart';
import 'package:talent_crm_app/features/voice/entities/voice_note.dart';

class VoiceRepository extends GetxService {
  final _voiceNotes = <VoiceNote>[].obs;

  List<VoiceNote> get voiceNotes => _voiceNotes.toList();

  void addVoiceNote(VoiceNote note) {
    _voiceNotes.insert(0, note);
  }

  void deleteVoiceNote(String id) {
    _voiceNotes.removeWhere((note) => note.id == id);
  }

  List<VoiceNote> getVoiceNotesByTalentId(String talentId) {
    return _voiceNotes.where((note) => note.talentId == talentId).toList();
  }
}
