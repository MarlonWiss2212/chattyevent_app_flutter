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

  MessageEntity mergeOrAdd({required MessageEntity message}) {
    int foundIndex = state.messages.indexWhere(
      (element) => element.id == message.id,
    );

    if (foundIndex != -1) {
      List<MessageEntity> newMessages = state.messages;
      newMessages[foundIndex] = MessageEntity.merge(
        newEntity: message,
        oldEntity: state.messages[foundIndex],
      );
      emit(
        MessageLoaded(messages: newMessages),
      );
      return newMessages[foundIndex];
    } else {
      emit(
        MessageLoaded(
          messages: List.from(state.messages)..add(message),
        ),
      );
    }
    return message;
  }

  List<MessageEntity> mergeOrAddMultiple({
    required List<MessageEntity> messages,
  }) {
    List<MessageEntity> mergedMessages = [];
    for (final message in messages) {
      // state will be changed in mergeOrAdd
      final mergedMessage = mergeOrAdd(message: message);
      mergedMessages.add(mergedMessage);
    }
    return mergedMessages;
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
        mergeOrAddMultiple(messages: messages);
      },
    );
  }
}
