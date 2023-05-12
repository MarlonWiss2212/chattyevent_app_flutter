part of 'chat_cubit.dart';

enum ChatStateStatus { initial, loading, success }

class ChatState {
  final ChatStateStatus status;
  final List<CurrentChatState> chatStates;

  const ChatState({
    required this.chatStates,
    this.status = ChatStateStatus.initial,
  });

  factory ChatState.merge({
    required List<CurrentChatState> chatStates,
    ChatStateStatus status = ChatStateStatus.initial,
  }) {
    chatStates.sort((a, b) {
      if (a.currentChat.latestMessage == null &&
          b.currentChat.latestMessage == null) {
        return 0;
      } else if (b.currentChat.latestMessage == null) {
        return -1;
      } else if (a.currentChat.latestMessage == null) {
        return 1;
      } else {
        return b.currentChat.latestMessage!.createdAt.compareTo(
          a.currentChat.latestMessage!.createdAt,
        );
      }
    });

    return ChatState(
      chatStates: chatStates,
      status: status,
    );
  }
}
