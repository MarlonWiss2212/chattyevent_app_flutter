import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCases chatUseCases;

  ChatBloc({required this.chatUseCases}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});

    on<ChatCreateEvent>((event, emit) async {
      final Either<Failure, GroupchatEntity> groupchatOrFailure =
          await chatUseCases.createGroupchatViaApi(
        createGroupchatDto: event.createGroupchatDto,
      );

      groupchatOrFailure.fold(
        (error) {
          if (state is ChatStateLoaded) {
            final state = this.state as ChatStateLoaded;
            emit(ChatStateLoaded(
              chats: state.chats,
              errorMessage: mapFailureToMessage(error),
            ));
          } else {
            emit(ChatStateError(message: mapFailureToMessage(error)));
          }
        },
        (groupchat) {
          if (state is ChatStateLoaded) {
            final state = this.state as ChatStateLoaded;
            emit(ChatStateLoaded(
              chats: List.from(state.chats)..add(groupchat),
            ));
          } else {
            emit(ChatStateLoaded(chats: [groupchat]));
          }
        },
      );
    });

    on<ChatRequestEvent>((event, emit) async {
      emit(ChatStateLoading());

      final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
          await chatUseCases.getGroupchatsViaApi();

      groupchatsOrFailure.fold(
        (error) => emit(
          ChatStateError(message: mapFailureToMessage(error)),
        ),
        (groupchats) => emit(
          ChatStateLoaded(chats: groupchats),
        ),
      );
    });
  }
}
