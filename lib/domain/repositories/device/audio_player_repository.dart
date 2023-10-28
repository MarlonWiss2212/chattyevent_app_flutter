import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class AudioPlayerRepository {
  Either<NotificationAlert, Stream<PlayerState>> onPlayerChanged();
  Either<NotificationAlert, Stream<Duration>> onDurationChanged();
  Either<NotificationAlert, Stream<Duration>> onPositionChanged();
  Future<Either<NotificationAlert, void>> pausePlaying();
  Future<Either<NotificationAlert, void>> resume();
  Future<Either<NotificationAlert, void>> seek({
    required Duration position,
  });
  Future<Either<NotificationAlert, void>> setAudioViaUrl({
    required String url,
  });
  Future<Either<NotificationAlert, void>> setAudioViaAsset({
    required String path,
  });
  Future<Either<NotificationAlert, Unit>> closePlayer();
}
