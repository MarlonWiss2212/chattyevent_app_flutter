import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  ChatCubit({required this.chatUseCases}) : super(const ChatState(chats: []));

  GroupchatEntity replaceOrAdd({
    required GroupchatEntity groupchat,
    required bool setMessagesFromOldEntity,
    required bool setLeftUsersFromOldEntity,
    required bool setUsersFromOldEntity,
  }) {
    int foundIndex = state.chats.indexWhere(
      (element) => element.id == groupchat.id,
    );

    if (foundIndex != -1) {
      List<GroupchatEntity> newGroupchats = state.chats;
      newGroupchats[foundIndex] = GroupchatEntity.merge(
        setMessagesFromOldEntity: setMessagesFromOldEntity,
        setLeftUsersFromOldEntity: setLeftUsersFromOldEntity,
        setUsersFromOldEntity: setUsersFromOldEntity,
        newEntity: groupchat,
        oldEntity: state.chats[foundIndex],
      );
      emit(ChatState(chats: newGroupchats));
      return newGroupchats[foundIndex];
    } else {
      emit(
        ChatState(
          chats: List.from(state.chats)..add(groupchat),
        ),
      );
    }
    return groupchat;
  }

  List<GroupchatEntity> replaceOrAddMultiple({
    required List<GroupchatEntity> groupchats,
    required bool setMessagesFromOldEntity,
    required bool setLeftUsersFromOldEntity,
    required bool setUsersFromOldEntity,
  }) {
    List<GroupchatEntity> mergedChats = [];
    for (final chat in groupchats) {
      final mergedChat = replaceOrAdd(
        groupchat: chat,
        setLeftUsersFromOldEntity: setLeftUsersFromOldEntity,
        setMessagesFromOldEntity: setMessagesFromOldEntity,
        setUsersFromOldEntity: setUsersFromOldEntity,
      );
      mergedChats.add(mergedChat);
    }
    return mergedChats;
  }

  void delete({required String groupchatId}) {
    List<GroupchatEntity> newChats = state.chats;
    newChats.removeWhere(
      (element) => element.id == groupchatId,
    );
    emit(ChatState(chats: newChats));
  }

  Future getChatsViaApi() async {
    emit(ChatState(chats: state.chats, status: ChatStateStatus.loading));

    final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
        await chatUseCases.getGroupchatsViaApi(
      limitOffsetFilter: LimitOffsetFilterOptional(
        limit: 1,
        offset: 0,
      ),
    );

    groupchatsOrFailure.fold(
      (error) => emit(
        ChatState(
          chats: state.chats,
          error: ErrorWithTitleAndMessage(
            message: mapFailureToMessage(error),
            title: "Fehler",
          ),
          status: ChatStateStatus.error,
        ),
      ),
      (groupchats) {
        replaceOrAddMultiple(
          groupchats: groupchats,
          setMessagesFromOldEntity: true,
          setLeftUsersFromOldEntity: false,
          setUsersFromOldEntity: false,
        );
      },
    );
  }
}
