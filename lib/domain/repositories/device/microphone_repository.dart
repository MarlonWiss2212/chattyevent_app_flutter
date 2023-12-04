import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';

abstract class MicrophoneRepository {
  /// Either return a [NotificationAlert] when an error occurred or
  /// returns a stream with the current recording disposition
  Either<NotificationAlert, Stream<RecordingDisposition>> isRecordingStream();

  // checks if the recorder is recording or not
  bool isRecording();

  /// Either return a [NotificationAlert] when an error occurred or
  /// starts recording
  Future<Either<NotificationAlert, Unit>> startRecording();

  /// Either return a [NotificationAlert] when an error occurred or
  /// stops recording
  Future<Either<NotificationAlert, String>> stopRecording();
}
