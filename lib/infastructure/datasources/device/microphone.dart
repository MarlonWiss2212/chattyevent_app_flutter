import 'package:audio_session/audio_session.dart';
import 'package:chattyevent_app_flutter/core/utils/directory_utils.dart';
import 'package:flutter_sound/flutter_sound.dart';

abstract class MicrophoneDatasource {
  Future<void> openRecorder();
  Future<void> openiOSSession();
  Future<void> closeRecorder();
  Stream<RecordingDisposition>? isRecordingStream();
  bool isRecording();
  Future<void> startRecording();
  Future<String?> stopRecording();
}

class MicrophoneDatasourceImpl implements MicrophoneDatasource {
  FlutterSoundRecorder recorder;
  MicrophoneDatasourceImpl({
    required this.recorder,
  });

  @override
  Future<void> openRecorder() {
    return recorder.openRecorder();
  }

  @override

  ///maybe delete in future when flutter_sound is updated
  Future<void> openiOSSession() async {
    //injection in future
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
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
