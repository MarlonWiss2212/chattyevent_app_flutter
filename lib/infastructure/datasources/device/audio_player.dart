import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayerDatasource {
  Stream<PlayerState> onPlayerChanged();
  Stream<Duration> onDurationChanged();
  Stream<Duration> onPositionChanged();
  Future<void> pausePlaying();
  Future<void> seek({required Duration position});
  Future<void> resume();
  Future<void> closePlayer();
  Future<void> setAudioPlayerViaUrl({required String url});
}

class AudioPlayerDatasourceImpl implements AudioPlayerDatasource {
  final AudioPlayer audioPlayer;
  AudioPlayerDatasourceImpl({required this.audioPlayer}) {
    audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  Stream<PlayerState> onPlayerChanged() {
    return audioPlayer.onPlayerStateChanged;
  }

  @override
  Stream<Duration> onDurationChanged() {
    return audioPlayer.onDurationChanged;
  }

  @override
  Stream<Duration> onPositionChanged() {
    return audioPlayer.onPositionChanged;
  }

  @override
  Future<void> pausePlaying() {
    return audioPlayer.pause();
  }

  @override
  Future<void> seek({required Duration position}) {
    return audioPlayer.seek(position);
  }

  @override
  Future<void> resume() {
    return audioPlayer.resume();
  }

  @override
  Future<void> closePlayer() {
    return audioPlayer.dispose();
  }

  @override
  Future<void> setAudioPlayerViaUrl({required String url}) {
    return audioPlayer.setSourceUrl(url);
  }
}
