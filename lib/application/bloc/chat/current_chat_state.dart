part of 'current_chat_cubit.dart';

@immutable
abstract class CurrentChatState {
  final GroupchatEntity currentChat;
  final List<UserWithGroupchatUserData> usersWithGroupchatUserData;
  final List<UserWithLeftGroupchatUserData> usersWithLeftGroupchatUserData;
  final List<PrivateEventEntity> privateEvents;

  final bool loadingChat;
  final bool loadingPrivateEvents;

  const CurrentChatState({
    required this.currentChat,
    required this.loadingChat,
    required this.loadingPrivateEvents,
    required this.privateEvents,
    required this.usersWithGroupchatUserData,
    required this.usersWithLeftGroupchatUserData,
  });
}

class CurrentChatNormal extends CurrentChatState {
  const CurrentChatNormal({
    required super.currentChat,
    required super.loadingChat,
    required super.usersWithGroupchatUserData,
    required super.usersWithLeftGroupchatUserData,
    required super.loadingPrivateEvents,
    required super.privateEvents,
  });
}

class CurrentChatError extends CurrentChatState {
  final String title;
  final String message;

  const CurrentChatError({
    required super.currentChat,
    required this.message,
    required this.title,
    required super.usersWithGroupchatUserData,
    required super.loadingChat,
    required super.usersWithLeftGroupchatUserData,
    required super.loadingPrivateEvents,
    required super.privateEvents,
  });
}
