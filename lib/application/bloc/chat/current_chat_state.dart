part of 'current_chat_cubit.dart';

@immutable
abstract class CurrentChatState {
  final GroupchatEntity currentChat;
  final bool loadingChat;
  const CurrentChatState({
    required this.currentChat,
    required this.loadingChat,
  });
}

class CurrentChatNormal extends CurrentChatState {
  const CurrentChatNormal({
    required super.currentChat,
    required super.loadingChat,
  });
}

class CurrentChatError extends CurrentChatState {
  final String title;
  final String message;

  const CurrentChatError({
    required super.currentChat,
    required this.message,
    required this.title,
    required super.loadingChat,
  });
}
