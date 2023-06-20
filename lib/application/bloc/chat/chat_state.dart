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
    /*
    chatStates.sort((a, b) {
      if ((a.groupchat?.latestMessage == null &&
              b.groupchat?.latestMessage == null) &&
          (a.privateEvent?.latestMessage == null &&
              b.privateEvent?.latestMessage == null) &&
          (a.user?.latestMessage == null && b.user?.latestMessage == null)) {
        return 0;
      } else if (b.groupchat?.latestMessage == null &&
          b.privateEvent?.latestMessage == null &&
          b.user?.latestMessage == null) {
        return -1;
      } else if (a.groupchat?.latestMessage == null &&
          a.privateEvent?.latestMessage == null &&
          a.user?.latestMessage == null) {
        return 1;
      } else if (a.groupchat?.latestMessage?.createdAt
              ?.isAfter(b.groupchat?.latestMessage?.createdAt) ??
          false ||
              a.privateEvent.latestMessage?.createdAt
                  ?.isAfter(b.privateEvent.latestMessage?.createdAt) ??
          false ||
              a.user.latestMessage?.createdAt
                  ?.isAfter(b.user.latestMessage?.createdAt) ??
          false) {
        return -1;
      } else {
        return 1;
      }
    });*/

    return ChatState(chats: chats, status: status);
  }
}
