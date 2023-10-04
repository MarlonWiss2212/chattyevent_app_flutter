import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/microphone_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/microphone.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';

class MicrophoneRepositoryImpl implements MicrophoneRepository {
  final MicrophoneDatasource microphoneDatasource;
  MicrophoneRepositoryImpl({
    required this.microphoneDatasource,
  });

  @override
  bool isRecording() {
    return microphoneDatasource.isRecording();
  }

  @override
  Either<NotificationAlert, Stream<RecordingDisposition>> isRecordingStream() {
    try {
      final isRecordingStream = microphoneDatasource.isRecordingStream();
      if (isRecordingStream == null) {
        return Left(
          NotificationAlert(
            title: "Fehler",
            message:
                "Fehler beim zugreifen auf den Status des Status ob eine Audio aufgenommen wird",
          ),
        );
      }
      return Right(isRecordingStream);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> startRecording() async {
    try {
      await microphoneDatasource.openRecorder();
      await microphoneDatasource.startRecording();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, String>> stopRecording() async {
    try {
      final link = await microphoneDatasource.stopRecording();
      await microphoneDatasource.closeRecorder();
      if (link == null) {
        return Left(NotificationAlert(
          title: "Fehler",
          message: "Fehler beim zurückgeben des aufgenommenen Audios",
        ));
      }
      return Right(link);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
