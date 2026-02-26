class VoiceNoteModel {
  final String id;
  final Duration duration;
  final DateTime createdAt;
  final String filePath;

  VoiceNoteModel({
    required this.id,
    required this.duration,
    required this.createdAt,
    required this.filePath,
  });

  String get durationFormatted {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }
}
