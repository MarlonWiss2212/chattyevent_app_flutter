import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final CurrentChatCubit currentChatCubit;
  final MessageUseCases messageUseCases;
  AddMessageCubit({
    required this.currentChatCubit,
    required this.messageUseCases,
  }) : super(AddMessageState());

  Future createMessage({required CreateMessageDto createMessageDto}) async {
    emitState(status: AddMessageStateStatus.loading);

    final Either<Failure, MessageEntity> messageOrFailure =
        await messageUseCases.createMessageViaApi(
      createMessageDto: createMessageDto,
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
        currentChatCubit.mergeOrAddMessage(message: message);
        emitState(
          status: AddMessageStateStatus.success,
          addedMessage: message,
        );
      },
    );
  }

  void emitState({
    AddMessageStateStatus? status,
    ErrorWithTitleAndMessage? error,
    MessageEntity? addedMessage,
  }) {
    emit(AddMessageState(
      status: status ?? AddMessageStateStatus.initial,
      error: error ?? state.error,
      addedMessage: addedMessage ?? state.addedMessage,
    ));
  }
}
