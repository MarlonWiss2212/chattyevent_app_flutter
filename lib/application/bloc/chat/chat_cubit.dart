import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  final NotificationCubit notificationCubit;
  ChatCubit({
    required this.chatUseCases,
    required this.notificationCubit,
  }) : super(const ChatState(
          chatStates: [],
        ));

  CurrentChatState replaceOrAdd({
    required CurrentChatState chatState,
  }) {
    int foundIndex = state.chatStates.indexWhere(
      (element) => element.currentChat.id == chatState.currentChat.id,
    );

    if (foundIndex != -1) {
      List<CurrentChatState> newChatStates = state.chatStates;
      newChatStates[foundIndex] = chatState;
      emit(ChatState(chatStates: newChatStates));
      return newChatStates[foundIndex];
    } else {
      emit(
        ChatState(
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
    emit(ChatState(chatStates: newChatStates));
  }

  Future getChatsViaApi() async {
    emit(
      ChatState(chatStates: state.chatStates, status: ChatStateStatus.loading),
    );

    final Either<NotificationAlert, List<GroupchatEntity>> groupchatsOrFailure =
        await chatUseCases.getGroupchatsViaApi();

    groupchatsOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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
