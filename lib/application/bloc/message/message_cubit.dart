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
    if (state is MessageStateLoaded) {
      final state = this.state as MessageStateLoaded;
      emit(
        MessageStateLoaded(
          messages: List.from(state.messages)..add(message),
        ),
      );
    } else {
      emit(MessageStateLoaded(messages: [message]));
    }
  }

  Future createMessage({required CreateMessageDto createMessageDto}) async {
    final Either<Failure, MessageEntity> messageOrFailure =
        await messageUseCases.createMessageViaApi(
      createMessageDto: createMessageDto,
    );

    messageOrFailure.fold(
      (error) {
        if (state is MessageStateLoaded) {
          final state = this.state as MessageStateLoaded;
          emit(MessageStateLoaded(
            messages: state.messages,
            errorMessage: mapFailureToMessage(error),
          ));
        } else {
          emit(MessageStateError(message: mapFailureToMessage(error)));
        }
      },
      (message) {
        if (state is MessageStateLoaded) {
          final state = this.state as MessageStateLoaded;
          emit(MessageStateLoaded(
            messages: List.from(state.messages)..add(message),
            createdMessageId: message.id,
          ));
        } else {
          emit(
            MessageStateLoaded(
              messages: [message],
              createdMessageId: message.id,
            ),
          );
        }
      },
    );
  }

  Future getMessages({required GetMessagesFilter getMessagesFilter}) async {
    if (state is MessageInitial) {
      emit(MessageStateLoading());
    }

    final Either<Failure, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      getMessagesFilter: getMessagesFilter,
    );

    messagesOrFailure.fold(
      (error) {
        if (state is MessageStateLoaded) {
          final state = this.state as MessageStateLoaded;
          emit(MessageStateLoaded(
            messages: state.messages,
            errorMessage: mapFailureToMessage(error),
          ));
        } else {
          emit(MessageStateError(message: mapFailureToMessage(error)));
        }
      },
      (messages) {
        if (state is MessageStateLoaded) {
          final state = this.state as MessageStateLoaded;

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
          emit(MessageStateLoaded(messages: messagesToEmit));
        } else {
          emit(
            MessageStateLoaded(messages: messages),
          );
        }
      },
    );
  }
}