import 'package:chattyevent_app_flutter/core/utils/directory_utils.dart';
import 'package:flutter_sound/flutter_sound.dart';

abstract class MicrophoneDatasource {
  Future<void> openRecorder();
  Future<void> closeRecorder();
  Stream<RecordingDisposition>? isRecordingStream();
  bool isRecording();
  Future<void> startRecording();
  Future<String?> stopRecording();
}

class MicrophoneDatasourceImpl implements MicrophoneDatasource {
  FlutterSoundRecorder recorder;
  MicrophoneDatasourceImpl({required this.recorder});

  @override
  Future<void> openRecorder() {
    return recorder.openRecorder();
  }

  @override
  Future<void> closeRecorder() {
    return recorder.closeRecorder();
  }

  @override
  bool isRecording() {
    return recorder.isRecording;
  }

  @override
  Stream<RecordingDisposition>? isRecordingStream() {
    return recorder.onProgress;
  }

  @override
  Future<void> startRecording() async {
    final path = await DirectoryUtils.getTemporaryPath();
    return recorder.startRecorder(
      toFile: "$path/audio.aac",
      codec: Codec.aacADTS,
    );
  }

  @override
  Future<String?> stopRecording() {
    return recorder.stopRecorder();
  }
}
