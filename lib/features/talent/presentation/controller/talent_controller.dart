import 'package:get/get.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';

class TalentController extends GetxController {
  final int id;
  final GetTalentByIdUseCase getTalentByIdUseCase;

  TalentController(this.getTalentByIdUseCase, this.id);

  final isLoading = false.obs;
  final error = RxnString();
  final talent = Rxn<Talent>();

  final voiceNotes = <VoiceNoteModel>[].obs;
  final isRecording = false.obs;
  final isPlayingId = RxnString();
  final audioError = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchTalent();
  }

  Future<void> fetchTalent() async {
    try {
      isLoading.value = true;
      error.value = null;

      final result = await getTalentByIdUseCase(id);
      talent.value = result;
    } catch (e) {
      error.value =
          e is Exception ? e.toString() : 'Erro inesperado ao carregar talento';
    } finally {
      isLoading.value = false;
    }
  }

  // 🔴 Start / Stop recording
  Future<void> toggleRecording() async {
    try {
      audioError.value = null;

      if (isRecording.value) {
        // Parar gravação
        isRecording.value = false;

        // MOCK temporário até integrar lib real
        voiceNotes.insert(
          0,
          VoiceNoteModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            duration: const Duration(seconds: 12),
            filePath: '',
            createdAt: DateTime.now(),
          ),
        );
      } else {
        // Iniciar gravação
        isRecording.value = true;
      }
    } catch (e) {
      audioError.value = 'Erro ao gravar áudio';
      isRecording.value = false;
    }
  }

  // 🔴 Play / Stop
  Future<void> togglePlay(VoiceNoteModel note) async {
    try {
      audioError.value = null;

      if (isPlayingId.value == note.id) {
        // stop
        isPlayingId.value = null;
        return;
      }

      // start
      isPlayingId.value = note.id;

      // Quando integrar player real,
      // você deve zerar isPlayingId quando terminar.
    } catch (e) {
      audioError.value = 'Erro ao reproduzir áudio';
      isPlayingId.value = null;
    }
  }

  // 🔴 Delete
  void deleteNote(String id) {
    if (isPlayingId.value == id) {
      isPlayingId.value = null;
    }

    voiceNotes.removeWhere((note) => note.id == id);
  }
}
