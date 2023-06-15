import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GroupchatUseCases groupchatUseCases;
  final NotificationCubit notificationCubit;
  ChatCubit({
    required this.groupchatUseCases,
    required this.notificationCubit,
  }) : super(const ChatState(
          chatStates: [],
        ));

  CurrentChatState replaceOrAdd({required CurrentChatState chatState}) {
    int foundIndex = state.chatStates.indexWhere(
      (element) => element.currentChat.id == chatState.currentChat.id,
    );

    if (foundIndex != -1) {
      List<CurrentChatState> newChatStates = state.chatStates;
      newChatStates[foundIndex] = chatState;
      emit(ChatState.merge(chatStates: newChatStates));
      return newChatStates[foundIndex];
    } else {
      emit(
        ChatState.merge(
          chatStates: List.from(state.chatStates)..add(chatState),
        ),
      );
    }
    return chatState;
  }

  List<CurrentChatState> replaceOrAddMultiple({
    required List<CurrentChatState> chatStates,
  }) {
    List<CurrentChatState> mergedChatStates = [];
    for (final chatState in chatStates) {
      final mergedChatState = replaceOrAdd(
        chatState: chatState,
      );
      mergedChatStates.add(mergedChatState);
    }
    return mergedChatStates;
  }

  void delete({required String groupchatId}) {
    List<CurrentChatState> newChatStates = state.chatStates;
    newChatStates.removeWhere(
      (element) => element.currentChat.id == groupchatId,
    );
    emit(ChatState.merge(chatStates: newChatStates));
  }

  Future getChatsViaApi() async {
    emit(
      ChatState(chatStates: state.chatStates, status: ChatStateStatus.loading),
    );

    final Either<NotificationAlert, List<GroupchatEntity>> groupchatsOrFailure =
        await groupchatUseCases.getGroupchatsViaApi();

    groupchatsOrFailure.fold(
      (alert) {
        ChatState(
          chatStates: state.chatStates,
          status: ChatStateStatus.initial,
        );
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (groupchats) {
        emit(
          ChatState(
            status: ChatStateStatus.success,
            chatStates: groupchats
                .map(
                  (e) => CurrentChatState(
                    currentUserIndex: -1,
                    currentUserLeftChat: false,
                    loadingPrivateEvents: false,
                    futureConnectedPrivateEvents: [],
                    loadingMessages: false,
                    currentChat: e,
                    messages: e.latestMessage != null ? [e.latestMessage!] : [],
                    loadingChat: false,
                    users: [],
                    leftUsers: [],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
