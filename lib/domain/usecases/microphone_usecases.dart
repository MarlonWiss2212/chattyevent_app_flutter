import 'package:chattyevent_app_flutter/domain/repositories/device/microphone_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class MicrophoneUseCases {
  final PermissionRepository permissionRepository;
  final MicrophoneRepository microphoneRepository;
  MicrophoneUseCases({
    required this.permissionRepository,
    required this.microphoneRepository,
  });

  Future<Either<NotificationAlert, Unit>> startRecording() async {
    PermissionStatus permissionStatus =
        await permissionRepository.getMicrophonePermissionStatus();

    if (permissionStatus.isDenied) {
      permissionStatus =
          await permissionRepository.requestMicrophonePermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(
        NotificationAlert(
          title: "Keine Mikrofon Berechtigung",
          message:
              "Bitte gib uns die Berechtigung für dein Mikrofon um eine Audio Datei aufnehmen zu können",
        ),
      );
    }
    final startedRecoder = await microphoneRepository.startRecording();
    return startedRecoder.fold(
      (alert) => Left(alert),
      (r) => const Right(unit),
    );
  }

  bool isRecording() => microphoneRepository.isRecording();

  Either<NotificationAlert, Stream<RecordingDisposition>> isRecordingStream() {
    return microphoneRepository.isRecordingStream();
  }

  Future<Either<NotificationAlert, String>> stopRecording() {
    return microphoneRepository.stopRecording();
  }
}
