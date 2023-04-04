import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/message/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final CurrentChatCubit currentChatCubit;
  final MessageUseCases messageUseCases;

  AddMessageCubit(
    super.initialState, {
    required this.currentChatCubit,
    required this.messageUseCases,
  });

  Future createMessage() async {
    emitState(status: AddMessageStateStatus.loading);

    if (state.message == null || state.groupchatTo == null) {
      emitState(
        status: AddMessageStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Ausfüll Fehler",
          message: "Bitte fülle erst alle Felder aus",
        ),
      );
    }

    final Either<Failure, MessageEntity> messageOrFailure =
        await messageUseCases.createMessageViaApi(
      createMessageDto: CreateMessageDto(
        message: state.message!,
        groupchatTo: state.groupchatTo!,
        messageToReactTo: state.messageToReactTo,
        file: state.file,
      ),
    );

    messageOrFailure.fold(
      (error) {
        emitState(
          status: AddMessageStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (message) {
        /// to reset everything else
        emit(AddMessageState(
          groupchatTo: state.groupchatTo,
          status: AddMessageStateStatus.success,
          addedMessage: message,
        ));
        currentChatCubit.addMessage(message: message);
      },
    );
  }

  void emitState({
    AddMessageStateStatus? status,
    ErrorWithTitleAndMessage? error,
    MessageEntity? addedMessage,
    File? file,
    bool removeFile = false,
    bool removeMessageToReactTo = false,
    String? message,
    String? groupchatTo,
    String? messageToReactTo,
  }) {
    emit(AddMessageState(
      message: message ?? state.message,
      messageToReactTo: removeMessageToReactTo
          ? null
          : messageToReactTo ?? state.messageToReactTo,
      groupchatTo: groupchatTo ?? state.groupchatTo,
      file: removeFile ? null : file ?? state.file,
      status: status ?? AddMessageStateStatus.initial,
      error: error ?? state.error,
      addedMessage: addedMessage ?? state.addedMessage,
    ));
  }
}
