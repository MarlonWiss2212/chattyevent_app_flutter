import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageUseCases messageUseCases;

  MessageBloc({required this.messageUseCases}) : super(MessageInitial()) {
    on<MessageEvent>((event, emit) {});

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
            ));
          } else {
            emit(MessageStateLoaded(messages: [message]));
          }
        },
      );
    });

    on<MessageRequestEvent>((event, emit) async {
      emit(MessageStateLoading());

      final Either<Failure, List<MessageEntity>> messagesOrFailure =
          await messageUseCases.getMessagesViaApi(
        getMessagesFilter: event.getMessagesFilter,
      );

      messagesOrFailure.fold(
        (error) => emit(
          MessageStateError(message: mapFailureToMessage(error)),
        ),
        (messages) => emit(
          MessageStateLoaded(messages: messages),
        ),
      );
    });
  }
}
