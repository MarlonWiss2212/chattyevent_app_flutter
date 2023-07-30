part of 'chat_cubit.dart';

enum ChatStateStatus { initial, loading, success }

class ChatState {
  final ChatStateStatus status;
  final List<ChatEntity> chats;

  const ChatState({
    required this.chats,
    this.status = ChatStateStatus.initial,
  });

  factory ChatState.merge({
    required List<ChatEntity> chats,
    ChatStateStatus status = ChatStateStatus.initial,
  }) {
    chats.sort((a, b) {
      final latestMessageA = a.groupchat?.latestMessage ??
          a.event?.latestMessage ??
          a.user?.latestMessage;

      final latestMessageB = b.groupchat?.latestMessage ??
          b.event?.latestMessage ??
          b.user?.latestMessage;

      if (latestMessageA == null && latestMessageB == null) {
        return 0;
      } else if (latestMessageB == null) {
        return -1;
      } else if (latestMessageA == null) {
        return 1;
      } else if (latestMessageA.createdAt.isAfter(latestMessageB.createdAt)) {
        return -1;
      } else {
        return 1;
      }
    });

    return ChatState(chats: chats, status: status);
  }
}
