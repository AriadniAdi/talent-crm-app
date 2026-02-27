import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';
import 'package:talent_crm_app/features/voice_recording/model/voice_note_model.dart';

class TalentController extends GetxController {
  final int id;
  final GetTalentByIdUseCase getTalentByIdUseCase;

  TalentController(this.getTalentByIdUseCase, this.id);

  final isLoading = false.obs;
  Rxn<AppError> screenError = Rxn<AppError>();
  final talent = Rxn<Talent>();

  final voiceNotes = <VoiceNoteModel>[].obs;
  final isRecording = false.obs;
  final isPlayingId = RxnString();
  final Rxn<AppError> audioError = Rxn<AppError>();

  @override
  void onInit() {
    super.onInit();
    fetchTalent();
  }

  Future<void> fetchTalent() async {
    isLoading.value = true;
    screenError.value = null;

    final result = await getTalentByIdUseCase(id);

    result.when(success: (data) {
      talent.value = data;
    }, failure: (error) {
      screenError.value = error;
    });

    isLoading.value = false;
  }

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
    } else {
      isRecording.value = true;
    }
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
