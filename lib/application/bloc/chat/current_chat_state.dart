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
}
