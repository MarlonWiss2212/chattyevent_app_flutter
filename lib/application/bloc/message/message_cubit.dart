import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageUseCases messageUseCases;

  MessageCubit({required this.messageUseCases}) : super(MessageInitial());

  void reset() {
    emit(MessageInitial());
  }

  void addMessage({required MessageEntity message}) {
    if (state is MessageLoaded) {
      final state = this.state as MessageLoaded;
      emit(
        MessageLoaded(
          messages: List.from(state.messages)..add(message),
        ),
      );
    } else {
      emit(
        MessageLoaded(
          messages: [message],
        ),
      );
    }
  }

  Future getMessages({required GetMessagesFilter getMessagesFilter}) async {
    emit(MessageLoading(
      messages: state.messages,
      loadingForGroupchatId: getMessagesFilter.groupchatTo ?? "",
    ));

    final Either<Failure, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      getMessagesFilter: getMessagesFilter,
    );

    messagesOrFailure.fold(
      (error) {
        MessageError(
          title: "Message Fehler",
          message: mapFailureToMessage(error),
          messages: state.messages,
        );
      },
      (messages) {
        List<MessageEntity> messagesToEmit = messages;

        for (final stateMessage in state.messages) {
          bool savedTheMessage = false;

          innerLoop:
          for (final messageToEmit in messagesToEmit) {
            if (messageToEmit.id == stateMessage.id) {
              savedTheMessage = true;
              break innerLoop;
            }
          }

          if (!savedTheMessage) {
            messagesToEmit.add(stateMessage);
          }
        }
        emit(MessageLoaded(
          messages: messagesToEmit,
        ));
      },
    );
  }
}
