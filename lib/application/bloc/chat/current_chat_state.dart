part of 'current_chat_cubit.dart';

class CurrentChatState {
  final GroupchatEntity currentChat;
  final List<UserWithGroupchatUserData> usersWithGroupchatUserData;
  final List<UserWithLeftGroupchatUserData> usersWithLeftGroupchatUserData;
  final List<PrivateEventEntity> privateEvents;

  final bool loadingChat;
  final bool loadingPrivateEvents;
  final bool loadingMessages;

  final ErrorWithTitleAndMessage? error;
  final bool showError;

  const CurrentChatState({
    this.error,
    this.showError = false,
    required this.loadingMessages,
    required this.currentChat,
    required this.loadingChat,
    required this.loadingPrivateEvents,
    required this.privateEvents,
    required this.usersWithGroupchatUserData,
    required this.usersWithLeftGroupchatUserData,
  });
}
