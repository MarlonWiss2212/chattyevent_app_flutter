import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  ChatCubit({required this.chatUseCases}) : super(ChatInitial());

  void reset() {
    emit(ChatInitial());
  }

  void addChat({required GroupchatEntity groupchat}) async {
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;
      List<GroupchatEntity> newChats = List.from(state.chats)..add(groupchat);
      emit(ChatLoaded(chats: newChats));
    } else {
      emit(ChatLoaded(chats: [groupchat]));
    }
  }

  GroupchatEntity editChatIfExistOrAdd({required GroupchatEntity groupchat}) {
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;

      int foundIndex = -1;
      state.chats.asMap().forEach((index, chatToFind) {
        if (chatToFind.id == groupchat.id) {
          foundIndex = index;
        }
      });

      if (foundIndex != -1) {
        List<GroupchatEntity> newGroupchats = state.chats;
        newGroupchats[foundIndex] = GroupchatEntity(
          id: groupchat.id,
          title: groupchat.title ?? newGroupchats[foundIndex].title,
          description:
              groupchat.description ?? newGroupchats[foundIndex].description,
          users: groupchat.users ?? newGroupchats[foundIndex].users,
          profileImageLink: groupchat.profileImageLink ??
              newGroupchats[foundIndex].profileImageLink,
          leftUsers: groupchat.leftUsers ?? newGroupchats[foundIndex].leftUsers,
          createdBy: groupchat.createdBy ?? newGroupchats[foundIndex].createdBy,
          createdAt: groupchat.createdAt ?? newGroupchats[foundIndex].createdAt,
        );
        emit(
          ChatLoaded(chats: newGroupchats),
        );
        return newGroupchats[foundIndex];
      } else {
        emit(
          ChatLoaded(
            chats: List.from(state.chats)..add(groupchat),
          ),
        );
      }
    } else {
      emit(
        ChatLoaded(
          chats: [groupchat],
        ),
      );
    }
    return groupchat;
  }

  Future getChatsViaApi() async {
    emit(ChatLoading());

    final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
        await chatUseCases.getGroupchatsViaApi();

    groupchatsOrFailure.fold(
      (error) => emit(
        ChatError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (groupchats) {
        emit(ChatLoaded(chats: groupchats));
      },
    );
  }
}
