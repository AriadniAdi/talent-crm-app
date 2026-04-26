import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/notifications/presentation/controller/notification_controller.dart';
import 'package:talent_crm_app/features/voice/data/voice_repository.dart';
import 'package:talent_crm_app/features/voice/entities/voice_note.dart';
import 'package:talent_crm_app/l10n/translate.dart';
import 'package:uuid/uuid.dart';

typedef DocumentsDirectoryProvider = Future<Directory> Function();

class VoiceController extends GetxController {
  final VoiceRepository _repository = Get.find<VoiceRepository>();

  final AudioRecorder _recorder;
  final AudioPlayer _player;
  final DocumentsDirectoryProvider _documentsDirectoryProvider;

  final isRecording = false.obs;
  final isPlayingId = RxnString();
  final audioError = Rxn<AppError>();
  final _stopwatch = Stopwatch();
  StreamSubscription<void>? _playerCompleteSubscription;

  final String? talentId;

  VoiceController({
    this.talentId,
    AudioRecorder? recorder,
    AudioPlayer? player,
    DocumentsDirectoryProvider? documentsDirectoryProvider,
  })
    : _recorder = recorder ?? AudioRecorder(),
      _player = player ?? AudioPlayer(),
      _documentsDirectoryProvider =
          documentsDirectoryProvider ?? getApplicationDocumentsDirectory;

  List<VoiceNote> get voiceNotes {
    if (talentId != null) {
      return _repository.voiceNotes.where((n) => n.talentId == talentId).toList();
    }
    return _repository.voiceNotes;
  }

  @override
  void onClose() {
    _playerCompleteSubscription?.cancel();
    _recorder.dispose();
    _player.dispose();
    super.onClose();
  }

  Future<void> toggleRecording() async {
    audioError.value = null;

    if (isRecording.value) {
      await _stopRecording();
      return;
    }

    try {
      if (await _recorder.hasPermission()) {
        final directory = await _documentsDirectoryProvider();
        final fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
        final path = '${directory.path}/$fileName';

        const config = RecordConfig();

        _stopwatch
          ..stop()
          ..reset()
          ..start();
        await _recorder.start(config, path: path);
        isRecording.value = true;
      } else {
        audioError.value = MessageError((t) => t.microphonePermissionDenied);
      }
    } catch (_) {
      _stopwatch
        ..stop()
        ..reset();
      isRecording.value = false;
      audioError.value = UnknownError();
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

      await _playerCompleteSubscription?.cancel();
      _playerCompleteSubscription = _player.onPlayerComplete.listen((event) {
        isPlayingId.value = null;
      });
    } catch (_) {
      audioError.value = MessageError((t) => t.audioPlaybackError);
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

  Future<void> _stopRecording() async {
    try {
      final path = await _recorder.stop();
      final duration = _stopwatch.elapsed;
      _stopwatch
        ..stop()
        ..reset();
      isRecording.value = false;

      if (path == null) {
        return;
      }

      final note = VoiceNote(
        id: const Uuid().v4(),
        talentId: talentId,
        duration: duration,
        filePath: path,
        createdAt: DateTime.now(),
      );
      _repository.addVoiceNote(note);

      final context = Get.context;
      if (context != null) {
        final notificationController = Get.find<NotificationController>();
        notificationController.addNotification(
          context.translate.voiceNoteSavedNotification,
          context.translate.voiceNoteSavedNotification,
        );
      }

      update();
    } catch (_) {
      _stopwatch
        ..stop()
        ..reset();
      isRecording.value = false;
      audioError.value = UnknownError();
    }
  }
}
