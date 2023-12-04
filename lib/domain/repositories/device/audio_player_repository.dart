import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class AudioPlayerRepository {
  /// Either return a [NotificationAlert] when an error occurred or
  /// returns a stream with the player state
  Either<NotificationAlert, Stream<PlayerState>> onPlayerChanged();

  /// Either return a [NotificationAlert] when an error occurred or
  /// returns a stream when the duration changed with the duration
  Either<NotificationAlert, Stream<Duration>> onDurationChanged();

  /// Either return a [NotificationAlert] when an error occurred or
  /// returns a stream when the position changed with the duration
  Either<NotificationAlert, Stream<Duration>> onPositionChanged();

  /// Either return a [NotificationAlert] when an error occurred or
  /// a void when it stopped playing
  Future<Either<NotificationAlert, void>> pausePlaying();

  /// Either return a [NotificationAlert] when an error occurred or
  /// a void when it resumed
  Future<Either<NotificationAlert, void>> resume();

  /// Either return a [NotificationAlert] when an error occurred or
  /// a void when the seeking worked
  Future<Either<NotificationAlert, void>> seek({
    required Duration position,
  });

  /// Either return a [NotificationAlert] when an error occurred or
  /// sets the audio file via the given [url]
  Future<Either<NotificationAlert, void>> setAudioViaUrl({
    required String url,
  });

  /// Either return a [NotificationAlert] when an error occurred or
  /// sets the audo file via the given [path]
  Future<Either<NotificationAlert, void>> setAudioViaAsset({
    required String path,
  });

  /// Either return a [NotificationAlert] when an error occurred or
  /// closes the player
  Future<Either<NotificationAlert, Unit>> closePlayer();
}
