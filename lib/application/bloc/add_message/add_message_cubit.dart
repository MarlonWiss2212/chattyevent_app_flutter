import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/geo_json/geo_json_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_and_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/microphone_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/vibration_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/geocoding/create_geo_json_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/message/create_message_location_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/message/create_message_dto.dart';
import 'package:flutter_sound/flutter_sound.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final Either<Either<CurrentEventCubit, CurrentGroupchatCubit>,
      ProfilePageCubit> cubitToAddMessageTo;
  final MessageUseCases messageUseCases;
  final ImagePickerUseCases imagePickerUseCases;
  final NotificationCubit notificationCubit;
  final VibrationUseCases vibrationUseCases;
  final LocationUseCases locationUseCases;
  final MicrophoneUseCases microphoneUseCases;

  AddMessageCubit(
    super.initialState, {
    required this.cubitToAddMessageTo,
    required this.messageUseCases,
    required this.notificationCubit,
    required this.imagePickerUseCases,
    required this.locationUseCases,
    required this.vibrationUseCases,
    required this.microphoneUseCases,
  });

  Future reactToMessage({
    required MessageAndUserEntity messageToReactToWithUser,
  }) async {
    final vibrate = await vibrationUseCases.vibrate(
      duration: 50,
      intensity: 50,
    );
    vibrate.fold(
      (alert) => null, //notificationCubit.newAlert(notificationAlert: alert),
      (r) => null,
    );
    emitState(messageToReactToWithUser: messageToReactToWithUser);
  }

  Future createMessage() async {
    if (state.status == AddMessageStateStatus.loading) return;
    emitState(status: AddMessageStateStatus.loading);

    if ((state.groupchatTo == null &&
        state.eventTo == null &&
        state.userTo == null)) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Ausfüll Fehler",
          message: "Bitte fülle erst alle Felder aus",
        ),
      );
      return;
    }

    final Either<NotificationAlert, MessageEntity> messageOrFailure =
        await messageUseCases.createMessageViaApi(
      createMessageDto: CreateMessageDto(
        message: state.message,
        groupchatTo: state.groupchatTo,
        userTo: state.userTo,
        voiceMessage: state.voiceMessage,
        currentLocation: state.lat != null && state.lon != null
            ? CreateMessageLocationDto(
                geoJson: CreateGeoJsonDto(
                  coordinates: [state.lon!, state.lat!],
                  type: GeoJsonTypeEnum.point,
                ),
              )
            : null,
        eventTo: state.eventTo,
        messageToReactToId: state.messageToReactToWithUser?.message.id,
        file: state.file,
      ),
    );

    messageOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AddMessageStateStatus.initial);
      },
      (message) {
        emit(AddMessageState(
          groupchatTo: state.groupchatTo,
          eventTo: state.eventTo,
          userTo: state.userTo,
          status: AddMessageStateStatus.success,
          addedMessage: message,
        ));
        cubitToAddMessageTo.fold(
          (either) => either.fold(
            (privateEventCubit) => privateEventCubit.addMessage(
              message: message,
              replaceOrAddInOtherCubits: true,
            ),
            (groupchatCubit) => groupchatCubit.addMessage(
              message: message,
              replaceOrAddInOtherCubits: true,
            ),
          ),
          (profileCubit) => profileCubit.addMessage(
            message: message,
            replaceOrAddInOtherCubits: true,
          ),
        );
      },
    );
  }

  Future<bool> startRecordingVoiceMessage() async {
    await microphoneUseCases.stopRecording();
    final alertOrVoid = await microphoneUseCases.startRecording();

    final vibrate = await vibrationUseCases.vibrate(
      duration: 50,
      intensity: 80,
    );
    vibrate.fold(
      (alert) => null, //notificationCubit.newAlert(notificationAlert: alert),
      (r) => null,
    );

    return alertOrVoid.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        return false;
      },
      (unit) {
        return microphoneUseCases.isRecordingStream().fold(
          (alert) {
            notificationCubit.newAlert(notificationAlert: alert);
            return false;
          },
          (stream) {
            emitState(isRecordingVoiceMessageStream: stream);
            return true;
          },
        );
      },
    );
  }

  Future stopRecordingVoiceMessageAndEmitIt() async {
    emitState(removeVoiceMessageStream: true);
    final vibrate = await vibrationUseCases.vibrate(
      duration: 50,
      intensity: 80,
    );
    vibrate.fold(
      (alert) => null, //notificationCubit.newAlert(notificationAlert: alert),
      (r) => null,
    );

    final alertOrPath = await microphoneUseCases.stopRecording();
    alertOrPath.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (path) {
        emitState(voiceMessage: File(path));
      },
    );
  }

  Future setFileFromCamera() async {
    final imagePickerErrorOrImage =
        await imagePickerUseCases.getImageFromCameraWithPermissions();

    imagePickerErrorOrImage.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (image) => emitState(file: image),
    );
  }

  Future setFileFromGallery() async {
    final imagePickerErrorOrImage =
        await imagePickerUseCases.getImageFromPhotosWithPermissions();

    imagePickerErrorOrImage.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (image) => emitState(file: image),
    );
  }

  Future setCurrentLocation() async {
    final positionOrAlert =
        await locationUseCases.getCurrentLocationWithPermissions();

    positionOrAlert.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (position) {
        emitState(
          lat: position.latitude,
          lon: position.longitude,
        );
      },
    );
  }

  void emitState({
    AddMessageStateStatus? status,
    MessageEntity? addedMessage,
    File? file,
    File? voiceMessage,
    Stream<RecordingDisposition>? isRecordingVoiceMessageStream,
    bool removeVoiceMessageStream = false,
    bool removeFile = false,
    bool removeVoiceMessage = false,
    bool removeMessageToReactTo = false,
    bool removeCurrentLocation = false,
    String? message,
    String? groupchatTo,
    MessageAndUserEntity? messageToReactToWithUser,
    String? userTo,
    double? lon,
    double? lat,
    String? eventTo,
  }) {
    emit(AddMessageState(
      isRecordingVoiceMessageStream: removeVoiceMessageStream
          ? null
          : isRecordingVoiceMessageStream ??
              state.isRecordingVoiceMessageStream,
      voiceMessage:
          removeVoiceMessage ? null : voiceMessage ?? state.voiceMessage,
      lat: removeCurrentLocation ? null : lat ?? state.lat,
      lon: removeCurrentLocation ? null : lon ?? state.lon,
      message: message ?? state.message,
      messageToReactToWithUser: removeMessageToReactTo
          ? null
          : messageToReactToWithUser ?? state.messageToReactToWithUser,
      groupchatTo: groupchatTo ?? state.groupchatTo,
      file: removeFile ? null : file ?? state.file,
      status: status ?? AddMessageStateStatus.initial,
      addedMessage: addedMessage ?? state.addedMessage,
      userTo: userTo ?? state.userTo,
      eventTo: eventTo ?? state.eventTo,
    ));
  }
}
