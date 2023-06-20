import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/chat_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCase chatUseCase;
  final NotificationCubit notificationCubit;
  ChatCubit({
    required this.chatUseCase,
    required this.notificationCubit,
  }) : super(const ChatState(chats: []));

  ChatEntity replaceOrAdd({
    required ChatEntity chat,
  }) {
    int foundIndex = state.chats.indexWhere((element) {
      if (element.groupchat != null && chat.groupchat != null) {
        return element.groupchat!.id == chat.groupchat!.id;
      } else if (element.privateEvent != null && chat.privateEvent != null) {
        return element.privateEvent!.id == chat.privateEvent!.id;
      } else if (element.user != null && chat.user != null) {
        return element.user!.id == chat.user!.id;
      }
      return false;
    });

    if (foundIndex != -1) {
      List<ChatEntity> newChats = state.chats;
      newChats[foundIndex] = chat;
      emit(ChatState.merge(chats: newChats));
      return newChats[foundIndex];
    } else {
      emit(ChatState.merge(chats: [chat, ...state.chats]));
    }
    return chat;
  }

  List<ChatEntity> replaceOrAddMultiple({
    required List<ChatEntity> chats,
  }) {
    List<ChatEntity> mergedChats = [];
    for (final chat in chats) {
      final mergedChat = replaceOrAdd(chat: chat);
      mergedChats.add(mergedChat);
    }
    return mergedChats;
  }

  void delete({
    String? groupchatId,
    String? privateEventId,
    String? userId,
  }) {
    List<ChatEntity> newChats = state.chats;
    newChats.removeWhere(
      (element) => groupchatId != null
          ? element.groupchat?.id == groupchatId
          : privateEventId != null
              ? element.privateEvent?.id == privateEventId
              : element.user?.id == userId,
    );
    emit(ChatState.merge(chats: newChats));
  }

  Future getChatsViaApi() async {
    emit(ChatState(chats: state.chats, status: ChatStateStatus.loading));

    final Either<NotificationAlert, List<ChatEntity>> groupchatsOrFailure =
        await chatUseCase.getChatsViaApi();

    groupchatsOrFailure.fold(
      (alert) {
        ChatState(chats: state.chats, status: ChatStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (chats) {
        emit(
          ChatState(status: ChatStateStatus.success, chats: chats),
        );
      },
    );
  }
}
