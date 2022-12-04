import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageUseCases messageUseCases;

  MessageBloc({required this.messageUseCases}) : super(MessageInitial()) {
    on<MessageEvent>((event, emit) {});
    on<MessageRequestEvent>((event, emit) async {
      emit(MessageStateLoading());

      final Either<Failure, List<MessageEntity>> messagesOrFailure =
          await messageUseCases.getMessagesViaApi();

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
