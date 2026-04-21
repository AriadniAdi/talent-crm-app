import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';
import 'package:talent_crm_app/features/voice/entities/voice_note.dart';
import 'package:uuid/uuid.dart';

class VoiceController extends GetxController {
  final VoiceRepository _repository = Get.find<VoiceRepository>();

  final AudioRecorder _recorder;
  final AudioPlayer _player;

  final isRecording = false.obs;
  final isPlayingId = RxnString();
  final audioError = Rxn<AppError>();

  final String? talentId;

  VoiceController({this.talentId, AudioRecorder? recorder, AudioPlayer? player})
    : _recorder = recorder ?? AudioRecorder(),
      _player = player ?? AudioPlayer();

  List<VoiceNote> get voiceNotes {
    if (talentId != null) {
      return _repository.voiceNotes.where((n) => n.talentId == talentId).toList();
    }
    return _repository.voiceNotes;
  }

  @override
  void onClose() {
    _recorder.dispose();
    _player.dispose();
    super.onClose();
  }

  Future<void> toggleRecording() async {
    audioError.value = null;

    if (isRecording.value) {
      final path = await _recorder.stop();
      isRecording.value = false;

      if (path != null) {
        final note = VoiceNote(
          id: const Uuid().v4(),
          talentId: talentId,
          duration: const Duration(seconds: 0),
          filePath: path,
          createdAt: DateTime.now(),
        );
        _repository.addVoiceNote(note);
        update();
      }
      return;
    }

    if (await _recorder.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      final path = '${directory.path}/$fileName';

      const config = RecordConfig();

      await _recorder.start(config, path: path);
      isRecording.value = true;
    } else {
      audioError.value = MessageError('Permissão de microfone negada');
    }
  }

  Future<void> togglePlay(VoiceNote note) async {
    audioError.value = null;

    if (isPlayingId.value == note.id) {
      await _player.stop();
      isPlayingId.value = null;
      return;
    }

    try {
      await _player.play(DeviceFileSource(note.filePath));
      isPlayingId.value = note.id;

      _player.onPlayerComplete.listen((event) {
        isPlayingId.value = null;
      });
    } catch (e) {
      audioError.value = MessageError('Erro ao reproduzir áudio');
    }
  }

  void deleteNote(String id) {
    if (isPlayingId.value == id) {
      _player.stop();
      isPlayingId.value = null;
    }

    _repository.deleteVoiceNote(id);
    update();
  }
}
