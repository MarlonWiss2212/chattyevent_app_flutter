part of 'chat_cubit.dart';

enum ChatStateStatus { initial, loading, success, error }

class ChatState {
  final ChatStateStatus status;
  final List<CurrentChatState> chatStates;
  final ErrorWithTitleAndMessage? error;

  const ChatState({
    required this.chatStates,
    this.status = ChatStateStatus.initial,
    this.error,
  });
}

class ChatError extends ChatState {
  final String title;
  final String message;
  const ChatError({
    required super.chatStates,
    required this.title,
    required this.message,
  });
}
