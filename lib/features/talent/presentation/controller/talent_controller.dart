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
  final observationText = ''.obs;
  final voiceNotes = <VoiceNoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTalent();
  }

  void updateObservation(String value) {
    observationText.value = value;
  }

  Future<void> fetchTalent() async {
    try {
      isLoading.value = true;
      error.value = null;

      final result = await getTalentByIdUseCase(id);
      talent.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void recordNote() {
    // Mock temporário
    voiceNotes.add(
      VoiceNoteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        duration: const Duration(),
        filePath: '',
        createdAt: DateTime.now(),
      ),
    );
  }
}
