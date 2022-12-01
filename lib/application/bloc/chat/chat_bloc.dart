import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCases chatUseCases;

  ChatBloc({required this.chatUseCases}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<ChatRequestEvent>((event, emit) async {
      emit(ChatStateLoading());

      final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
          await chatUseCases.getGroupchatsViaApi();

      groupchatsOrFailure.fold(
        (error) => emit(
          ChatStateError(
            message: mapFailureToMessage(error),
          ),
        ),
        (groupchats) => emit(
          ChatStateLoaded(chats: groupchats),
        ),
      );
    });
  }
}
