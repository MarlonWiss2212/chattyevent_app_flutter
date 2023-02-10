import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final MessageCubit messageCubit;
  final MessageUseCases messageUseCases;
  AddMessageCubit({
    required this.messageCubit,
    required this.messageUseCases,
  }) : super(AddMessageInitial());

  void reset() {
    emit(AddMessageInitial());
  }

  Future createMessage({required CreateMessageDto createMessageDto}) async {
    emit(AddMessageLoading());

    final Either<Failure, MessageEntity> messageOrFailure =
        await messageUseCases.createMessageViaApi(
      createMessageDto: createMessageDto,
    );

    messageOrFailure.fold(
      (error) {
        emit(
          AddMessageError(title: "Fehler", message: mapFailureToMessage(error)),
        );
      },
      (message) {
        messageCubit.mergeOrAdd(message: message);
        emit(AddMessageLoaded(addedMessage: message));
      },
    );
  }
}
