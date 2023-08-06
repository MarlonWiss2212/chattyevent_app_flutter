import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/audio_player_repository.dart';
import 'package:dartz/dartz.dart';

class AudioPlayerUseCases {
  final AudioPlayerRepository audioPlayerRepository;
  AudioPlayerUseCases({required this.audioPlayerRepository});

  Future<Either<NotificationAlert, Unit>> closePlayer() async {
    return audioPlayerRepository.closePlayer();
  }

  Either<NotificationAlert, Stream<Duration>> onDurationChanged() {
    return audioPlayerRepository.onDurationChanged();
  }

  Either<NotificationAlert, Stream<PlayerState>> onPlayerChanged() {
    return audioPlayerRepository.onPlayerChanged();
  }

  Either<NotificationAlert, Stream<Duration>> onPositionChanged() {
    return audioPlayerRepository.onPositionChanged();
  }

  Future<Either<NotificationAlert, void>> pausePlaying() async {
    return audioPlayerRepository.pausePlaying();
  }

  Future<Either<NotificationAlert, void>> resume({Duration? position}) async {
    if (position != null) {
      audioPlayerRepository.seek(position: position);
    }
    return audioPlayerRepository.resume();
  }

  Future<Either<NotificationAlert, void>> setAudioViaUrl({
    required String url,
  }) async {
    return audioPlayerRepository.setAudioViaUrl(url: url);
  }

  Future<Either<NotificationAlert, void>> seek({
    required Duration position,
  }) {
    return audioPlayerRepository.seek(position: position);
  }
}
