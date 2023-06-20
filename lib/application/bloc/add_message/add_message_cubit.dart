import 'dart:io';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/message/create_message_dto.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final CurrentGroupchatCubit currentGroupchatCubit;
  final MessageUseCases messageUseCases;
  final NotificationCubit notificationCubit;

  AddMessageCubit(
    super.initialState, {
    required this.currentGroupchatCubit,
    required this.messageUseCases,
    required this.notificationCubit,
  });

  Future createMessage() async {
    emitState(status: AddMessageStateStatus.loading);

    if (state.message == null || state.groupchatTo == null) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Ausfüll Fehler",
          message: "Bitte fülle erst alle Felder aus",
        ),
      );
    }

    final Either<NotificationAlert, MessageEntity> messageOrFailure =
        await messageUseCases.createMessageViaApi(
      createMessageDto: CreateMessageDto(
        message: state.message!,
        groupchatTo: state.groupchatTo!,
        messageToReactTo: state.messageToReactTo?.id,
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
          status: AddMessageStateStatus.success,
          addedMessage: message,
        ));
        currentGroupchatCubit.addMessage(message: message);
      },
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
    MessageEntity? messageToReactTo,
  }) {
    emit(AddMessageState(
      message: message ?? state.message,
      messageToReactTo: removeMessageToReactTo
          ? null
          : messageToReactTo ?? state.messageToReactTo,
      groupchatTo: groupchatTo ?? state.groupchatTo,
      file: removeFile ? null : file ?? state.file,
      status: status ?? AddMessageStateStatus.initial,
      addedMessage: addedMessage ?? state.addedMessage,
    ));
  }
}
