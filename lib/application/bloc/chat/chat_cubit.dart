import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  ChatCubit({required this.chatUseCases}) : super(ChatInitial());

  void reset() {
    emit(ChatInitial());
  }

  void addChat({required GroupchatEntity groupchat}) {
    if (state is ChatStateLoaded) {
      final state = this.state as ChatStateLoaded;
      emit(
        ChatStateLoaded(
          chats: List.from(state.chats)..add(groupchat),
        ),
      );
    } else {
      emit(ChatStateLoaded(chats: [groupchat]));
    }
  }

  void editChatIfExistOrAdd({required GroupchatEntity groupchat}) {
    if (state is ChatStateLoaded) {
      final state = this.state as ChatStateLoaded;

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
          leftUsers: groupchat.leftUsers ?? newGroupchats[foundIndex].leftUsers,
          createdBy: groupchat.createdBy ?? newGroupchats[foundIndex].createdBy,
          createdAt: groupchat.createdAt ?? newGroupchats[foundIndex].createdAt,
        );
        emit(
          ChatStateLoaded(chats: newGroupchats),
        );
      } else {
        emit(
          ChatStateLoaded(chats: List.from(state.chats)..add(groupchat)),
        );
      }
    } else {
      emit(
        ChatStateLoaded(
          chats: [groupchat],
        ),
      );
    }
  }

  GroupchatEntity? getGroupchatById({required String groupchatId}) {
    if (state is ChatStateLoaded) {
      final state = this.state as ChatStateLoaded;
      for (final chat in state.chats) {
        if (chat.id == groupchatId) {
          return chat;
        }
      }
    }
    return null;
  }

  Future getChatsViaApi() async {
    emit(ChatStateLoading());

    final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
        await chatUseCases.getGroupchatsViaApi();

    groupchatsOrFailure.fold(
      (error) => emit(
        ChatStateError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (groupchats) => emit(
        ChatStateLoaded(chats: groupchats),
      ),
    );
  }
}
