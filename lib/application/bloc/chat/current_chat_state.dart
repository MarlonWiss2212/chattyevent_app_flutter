part of 'current_chat_cubit.dart';

@immutable
abstract class CurrentChatState {
  final GroupchatEntity currentChat;
  const CurrentChatState({required this.currentChat});
}

class CurrentChatInitial extends CurrentChatState {
  const CurrentChatInitial({required super.currentChat});
}

class CurrentChatLoading extends CurrentChatState {
  const CurrentChatLoading({required super.currentChat});
}

class CurrentChatError extends CurrentChatState {
  final String title;
  final String message;

  const CurrentChatError({
    required super.currentChat,
    required this.message,
    required this.title,
  });
}

class CurrentChatLoaded extends CurrentChatState {
  const CurrentChatLoaded({required super.currentChat});
}
