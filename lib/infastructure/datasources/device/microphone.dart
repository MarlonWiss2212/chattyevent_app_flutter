import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

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
  FlutterSoundPlayer player;
  MicrophoneDatasourceImpl({
    required this.recorder,
    required this.player,
  });

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
    //TODO: make get TemporaryDirecatory better
    var tempDir = await getTemporaryDirectory();
    return recorder.startRecorder(
      toFile: "${tempDir.path}/audio.aac",
      codec: Codec.aacADTS,
    );
  }

  @override
  Future<String?> stopRecording() {
    return recorder.stopRecorder();
  }
}
