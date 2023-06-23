import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/message/create_message_dto.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final Either<Either<CurrentPrivateEventCubit, CurrentGroupchatCubit>,
      ProfilePageCubit> cubitToAddMessageTo;
  final MessageUseCases messageUseCases;
  final ImagePickerUseCases imagePickerUseCases;
  final NotificationCubit notificationCubit;

  AddMessageCubit(
    super.initialState, {
    required this.cubitToAddMessageTo,
    required this.messageUseCases,
    required this.notificationCubit,
    required this.imagePickerUseCases,
  });

  Future createMessage() async {
    emitState(status: AddMessageStateStatus.loading);

    if (state.message == null ||
        (state.groupchatTo == null &&
            state.privateEventTo == null &&
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
        message: state.message!,
        groupchatTo: state.groupchatTo,
        userTo: state.userTo,
        privateEventTo: state.privateEventTo,
        messageToReactTo: state.messageToReactToWithUser?.message.id,
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
          privateEventTo: state.privateEventTo,
          userTo: state.userTo,
          status: AddMessageStateStatus.success,
          addedMessage: message,
        ));
        cubitToAddMessageTo.fold(
          (either) => either.fold(
            (privateEventCubit) =>
                privateEventCubit.addMessage(message: message),
            (groupchatCubit) => groupchatCubit.addMessage(message: message),
          ),
          (profileCubit) => profileCubit.addMessage(message: message),
        );
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

  void emitState({
    AddMessageStateStatus? status,
    MessageEntity? addedMessage,
    File? file,
    bool removeFile = false,
    bool removeMessageToReactTo = false,
    String? message,
    String? groupchatTo,
    MessageAndUser? messageToReactToWithUser,
    String? userTo,
    String? privateEventTo,
  }) {
    emit(AddMessageState(
      message: message ?? state.message,
      messageToReactToWithUser: removeMessageToReactTo
          ? null
          : messageToReactToWithUser ?? state.messageToReactToWithUser,
      groupchatTo: groupchatTo ?? state.groupchatTo,
      file: removeFile ? null : file ?? state.file,
      status: status ?? AddMessageStateStatus.initial,
      addedMessage: addedMessage ?? state.addedMessage,
      userTo: userTo ?? state.userTo,
      privateEventTo: privateEventTo ?? state.privateEventTo,
    ));
  }
}
