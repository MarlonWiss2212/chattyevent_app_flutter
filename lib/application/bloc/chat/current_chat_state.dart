part of 'current_chat_cubit.dart';

class CurrentChatState {
  final GroupchatEntity currentChat;
  final List<UserWithGroupchatUserData> users;
  final int currentUserIndex;

  final List<UserWithLeftGroupchatUserData> leftUsers;

  final List<PrivateEventEntity> futureConnectedPrivateEvents;
  final bool loadingPrivateEvents;

  final bool currentUserLeftChat;

  final bool loadingChat;
  final bool loadingMessages;

  final ErrorWithTitleAndMessage? error;
  final bool showError;

  UserWithGroupchatUserData? getCurrentGroupchatUser() {
    if (currentUserIndex != -1) {
      return users[currentUserIndex];
    }
    return null;
  }

  const CurrentChatState({
    this.error,
    this.showError = false,
    required this.currentUserIndex,
    required this.currentUserLeftChat,
    required this.loadingPrivateEvents,
    required this.futureConnectedPrivateEvents,
    required this.loadingMessages,
    required this.currentChat,
    required this.loadingChat,
    required this.users,
    required this.leftUsers,
  });

  factory CurrentChatState.merge({
    required CurrentChatState oldState,
    bool mergeChatSetMessagesFromOldEntity = false,
    bool mergeChatSetLeftUsersFromOldEntity = false,
    bool mergeChatSetUsersFromOldEntity = false,
    GroupchatEntity? currentChat,
    List<UserWithGroupchatUserData>? users,
    int? currentUserIndex,
    List<UserWithLeftGroupchatUserData>? leftUsers,
    List<PrivateEventEntity>? futureConnectedPrivateEvents,
    bool? loadingPrivateEvents,
    bool? currentUserLeftChat,
    bool? loadingChat,
    bool? loadingMessages,
    ErrorWithTitleAndMessage? error,
    bool showError = false,
  }) {
    return CurrentChatState(
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
              mergeChatSetLeftUsersFromOldEntity:
                  mergeChatSetLeftUsersFromOldEntity,
              mergeChatSetMessagesFromOldEntity:
                  mergeChatSetMessagesFromOldEntity,
              mergeChatSetUsersFromOldEntity:
                  mergeChatSetLeftUsersFromOldEntity,
            )
          : oldState.currentChat,
      loadingChat: loadingChat ?? oldState.loadingChat,
      users: users ?? oldState.users,
      leftUsers: leftUsers ?? oldState.leftUsers,
      error: error ?? oldState.error,
      showError: showError,
    );
  }
}
