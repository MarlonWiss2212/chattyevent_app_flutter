part of 'current_chat_cubit.dart';

class CurrentChatState {
  final GroupchatEntity currentChat;
  final int currentUserIndex;

  final List<GroupchatUserEntity> users;
  final List<GroupchatLeftUserEntity> leftUsers;

  final List<MessageEntity> messages;

  final List<PrivateEventEntity> futureConnectedPrivateEvents;
  final bool loadingPrivateEvents;

  final bool currentUserLeftChat;

  final bool loadingChat;
  final bool loadingMessages;

  GroupchatUserEntity? getCurrentGroupchatUser() {
    if (currentUserIndex != -1) {
      return users[currentUserIndex];
    }
    return null;
  }

  const CurrentChatState({
    required this.currentUserIndex,
    required this.currentUserLeftChat,
    required this.loadingPrivateEvents,
    required this.futureConnectedPrivateEvents,
    required this.loadingMessages,
    required this.messages,
    required this.currentChat,
    required this.loadingChat,
    required this.users,
    required this.leftUsers,
  });

  factory CurrentChatState.merge({
    required CurrentChatState oldState,
    GroupchatEntity? currentChat,
    List<GroupchatUserEntity>? users,
    int? currentUserIndex,
    List<GroupchatLeftUserEntity>? leftUsers,
    List<PrivateEventEntity>? futureConnectedPrivateEvents,
    List<MessageEntity>? messages,
    bool? loadingPrivateEvents,
    bool? currentUserLeftChat,
    bool? loadingChat,
    bool? loadingMessages,
  }) {
    /// sort messages
    final allMessages = messages ?? oldState.messages;
    allMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    return CurrentChatState(
      messages: allMessages,
      currentUserIndex: currentUserIndex ?? oldState.currentUserIndex,
      currentUserLeftChat: currentUserLeftChat ?? oldState.currentUserLeftChat,
      loadingPrivateEvents:
          loadingPrivateEvents ?? oldState.loadingPrivateEvents,
      futureConnectedPrivateEvents:
          futureConnectedPrivateEvents ?? oldState.futureConnectedPrivateEvents,
      loadingMessages: loadingMessages ?? oldState.loadingMessages,
      currentChat: currentChat != null
          ? GroupchatEntity.merge(
              newEntity: currentChat,
              oldEntity: oldState.currentChat,
            )
          : oldState.currentChat,
      loadingChat: loadingChat ?? oldState.loadingChat,
      users: users ?? oldState.users,
      leftUsers: leftUsers ?? oldState.leftUsers,
    );
  }
}
