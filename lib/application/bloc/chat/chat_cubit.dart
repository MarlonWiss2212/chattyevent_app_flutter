import 'dart:math';

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

  GroupchatEntity mergeOrAdd({required GroupchatEntity groupchat}) {
    int foundIndex = state.chats.indexWhere(
      (element) => element.id == groupchat.id,
    );

    if (foundIndex != -1) {
      List<GroupchatEntity> newGroupchats = state.chats;
      newGroupchats[foundIndex] = GroupchatEntity.merge(
        newEntity: groupchat,
        oldEntity: state.chats[foundIndex],
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

  List<GroupchatEntity> mergeOrAddMultiple({
    required List<GroupchatEntity> groupchats,
  }) {
    List<GroupchatEntity> mergedChats = [];
    for (final chat in groupchats) {
      // state will be changed in mergeOrAdd
      final mergedChat = mergeOrAdd(groupchat: chat);
      mergedChats.add(mergedChat);
    }
    return mergedChats;
  }

  void delete({required String groupchatId}) {
    List<GroupchatEntity> newChats = state.chats;
    newChats.removeWhere(
      (element) => element.id == groupchatId,
    );
    emit(ChatLoaded(chats: newChats));
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
        mergeOrAddMultiple(groupchats: groupchats);
      },
    );
  }
}
