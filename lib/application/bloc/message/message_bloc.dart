import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/infastructure/models/message/message_model.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageUseCases messageUseCases;

  MessageBloc({required this.messageUseCases}) : super(MessageInitial()) {
    on<MessageEvent>((event, emit) {});

    on<MessageListenEvent>((event, emit) {
      messageUseCases.getMessagesRealtimeViaApi().listen((event) {
        print(event);
        final message = MessageModel.fromJson(event.data!["messageAdded"]);
        if (state is MessageStateLoaded) {
          final state = this.state as MessageStateLoaded;

          bool messageIsAlreadyLoaded = false;

          for (final stateMessage in state.messages) {
            if (stateMessage.id == message.id) {
              messageIsAlreadyLoaded = true;
              break;
            }
          }
          if (!messageIsAlreadyLoaded) {
            emit(
              MessageStateLoaded(
                messages: List.from(state.messages)..add(message),
              ),
            );
          }
        } else {
          emit(MessageStateLoaded(messages: [message]));
        }
      });
    });

    on<MessageInitialEvent>((event, emit) {
      emit(MessageInitial());
    });

    on<MessageCreateEvent>((event, emit) async {
      final Either<Failure, MessageEntity> messageOrFailure =
          await messageUseCases.createMessageViaApi(
        createMessageDto: event.createMessageDto,
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
    });

    on<GetMessagesEvent>((event, emit) async {
      if (state is MessageInitial) {
        emit(MessageStateLoading());
      }

      final Either<Failure, List<MessageEntity>> messagesOrFailure =
          await messageUseCases.getMessagesViaApi(
        getMessagesFilter: event.getMessagesFilter,
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
    });
  }
}
