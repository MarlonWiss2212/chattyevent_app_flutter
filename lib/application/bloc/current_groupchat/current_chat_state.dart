part of 'current_chat_cubit.dart';

class CurrentGroupchatState {
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

  const CurrentGroupchatState({
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

  factory CurrentGroupchatState.fromGroupchat({
    required GroupchatEntity groupchat,
  }) {
    return CurrentGroupchatState(
      currentChat: groupchat,
      messages: [],
      currentUserIndex: -1,
      currentUserLeftChat: false,
      futureConnectedPrivateEvents: [],
      loadingChat: false,
      leftUsers: [],
      loadingMessages: false,
      loadingPrivateEvents: false,
      users: [],
    );
  }

  factory CurrentGroupchatState.merge({
    required CurrentGroupchatState oldState,
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
    final List<MessageEntity> allMessages = messages ?? oldState.messages;
    allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    GroupchatEntity newChat = currentChat ?? oldState.currentChat;
    allMessages.isNotEmpty
        ? newChat = GroupchatEntity.merge(
            newEntity: GroupchatEntity(
              id: newChat.id,
              latestMessage: allMessages.first,
            ),
            oldEntity: newChat,
          )
        : null;

    return CurrentGroupchatState(
      messages: allMessages,
      currentUserIndex: currentUserIndex ?? oldState.currentUserIndex,
      currentUserLeftChat: currentUserLeftChat ?? oldState.currentUserLeftChat,
      loadingPrivateEvents:
          loadingPrivateEvents ?? oldState.loadingPrivateEvents,
      futureConnectedPrivateEvents:
          futureConnectedPrivateEvents ?? oldState.futureConnectedPrivateEvents,
      loadingMessages: loadingMessages ?? oldState.loadingMessages,
      currentChat: newChat,
      loadingChat: loadingChat ?? oldState.loadingChat,
      users: users ?? oldState.users,
      leftUsers: leftUsers ?? oldState.leftUsers,
    );
  }
}
