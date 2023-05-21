import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_message/create_groupchat_message_dto.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat/groupchat_message_usecases.dart';

part 'add_groupchat_message_state.dart';

class AddGroupchatMessageCubit extends Cubit<AddGroupchatMessageState> {
  final CurrentChatCubit currentChatCubit;
  final GroupchatMessageUseCases groupchatMessageUseCases;
  final NotificationCubit notificationCubit;

  AddGroupchatMessageCubit(
    super.initialState, {
    required this.currentChatCubit,
    required this.groupchatMessageUseCases,
    required this.notificationCubit,
  });

  Future createMessage() async {
    emitState(status: AddGroupchatMessageStateStatus.loading);

    if (state.message == null || state.groupchatTo == null) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Ausfüll Fehler",
          message: "Bitte fülle erst alle Felder aus",
        ),
      );
    }

    final Either<NotificationAlert, GroupchatMessageEntity> messageOrFailure =
        await groupchatMessageUseCases.createGroupchatMessageViaApi(
      createGroupchatMessageDto: CreateGroupchatMessageDto(
        message: state.message!,
        groupchatTo: state.groupchatTo!,
        messageToReactTo: state.messageToReactTo,
        file: state.file,
      ),
    );

    messageOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AddGroupchatMessageStateStatus.initial);
      },
      (message) {
        emit(AddGroupchatMessageState(
          groupchatTo: state.groupchatTo,
          status: AddGroupchatMessageStateStatus.success,
          addedMessage: message,
        ));
        currentChatCubit.addMessage(message: message);
      },
    );
  }

  void emitState({
    AddGroupchatMessageStateStatus? status,
    GroupchatMessageEntity? addedMessage,
    File? file,
    bool removeFile = false,
    bool removeMessageToReactTo = false,
    String? message,
    String? groupchatTo,
    String? messageToReactTo,
  }) {
    emit(AddGroupchatMessageState(
      message: message ?? state.message,
      messageToReactTo: removeMessageToReactTo
          ? null
          : messageToReactTo ?? state.messageToReactTo,
      groupchatTo: groupchatTo ?? state.groupchatTo,
      file: removeFile ? null : file ?? state.file,
      status: status ?? AddGroupchatMessageStateStatus.initial,
      addedMessage: addedMessage ?? state.addedMessage,
    ));
  }
}
