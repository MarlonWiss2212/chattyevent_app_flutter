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

  void addChat({required GroupchatEntity groupchat}) {
    emit(ChatLoaded(chats: List.from(state.chats)..add(groupchat)));
  }

  GroupchatEntity editChatIfExistOrAdd({required GroupchatEntity groupchat}) {
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
    return groupchat;
  }

  Future getChatsViaApi() async {
    emit(ChatLoading(chats: state.chats));

    final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
        await chatUseCases.getGroupchatsViaApi();

    groupchatsOrFailure.fold(
      (error) => emit(
        ChatError(
          chats: state.chats,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (groupchats) {
        List<GroupchatEntity> chatsToEmit = groupchats;

        for (final stateChat in state.chats) {
          bool savedTheChat = false;

          innerLoop:
          for (final chatToEmit in chatsToEmit) {
            if (chatToEmit.id == stateChat.id) {
              savedTheChat = true;
              break innerLoop;
            }
          }

          if (!savedTheChat) {
            chatsToEmit.add(stateChat);
          }
        }
        emit(ChatLoaded(chats: chatsToEmit));
      },
    );
  }
}
