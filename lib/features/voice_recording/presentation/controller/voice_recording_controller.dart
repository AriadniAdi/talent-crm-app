import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';

class VoiceRecordingController extends GetxController {
  final voiceNotes = <VoiceNoteModel>[].obs;
  final isRecording = false.obs;
  final isPlayingId = RxnString();
  final audioError = Rxn<AppError>();

  Future<void> toggleRecording() async {
    audioError.value = null;

    if (isRecording.value) {
      isRecording.value = false;

      voiceNotes.insert(
        0,
        VoiceNoteModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          duration: const Duration(seconds: 12),
          filePath: '',
          createdAt: DateTime.now(),
        ),
      );

      return;
    }

    isRecording.value = true;
  }

  void togglePlay(VoiceNoteModel note) {
    audioError.value = null;

    if (isPlayingId.value == note.id) {
      isPlayingId.value = null;
      return;
    }

    isPlayingId.value = note.id;
  }

  void deleteNote(String id) {
    if (isPlayingId.value == id) {
      isPlayingId.value = null;
    }

    voiceNotes.removeWhere((note) => note.id == id);
  }
}
