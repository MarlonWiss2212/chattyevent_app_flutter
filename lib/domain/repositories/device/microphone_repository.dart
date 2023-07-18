import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';

abstract class MicrophoneRepository {
  Either<NotificationAlert, Stream<RecordingDisposition>> isRecordingStream();
  bool isRecording();
  Future<Either<NotificationAlert, Unit>> startRecording();
  Future<Either<NotificationAlert, String>> stopRecording();
}
