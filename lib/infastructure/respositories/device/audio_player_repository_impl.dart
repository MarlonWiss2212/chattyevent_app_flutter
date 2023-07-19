import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/audio_player_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/audio_player.dart';
import 'package:dartz/dartz.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final AudioPlayerDatasource audioPlayerDataource;
  AudioPlayerRepositoryImpl({required this.audioPlayerDataource});

  @override
  Future<Either<NotificationAlert, Unit>> closePlayer() async {
    try {
      await audioPlayerDataource.closePlayer();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, Stream<Duration>> onDurationChanged() {
    try {
      final stream = audioPlayerDataource.onDurationChanged();
      return Right(stream);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, Stream<PlayerState>> onPlayerChanged() {
    try {
      final stream = audioPlayerDataource.onPlayerChanged();
      return Right(stream);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, Stream<Duration>> onPositionChanged() {
    try {
      final stream = audioPlayerDataource.onPositionChanged();
      return Right(stream);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> pausePlaying() async {
    try {
      await audioPlayerDataource.pausePlaying();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> resume({Duration? position}) async {
    try {
      if (position != null) {
        await audioPlayerDataource.seek(position: position);
      }
      await audioPlayerDataource.resume();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> setAudioViaUrl({
    required String url,
  }) async {
    try {
      await audioPlayerDataource.setAudioPlayerViaUrl(url: url);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> seek({
    required Duration position,
  }) async {
    try {
      await audioPlayerDataource.seek(position: position);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
