part of 'current_chat_cubit.dart';

@immutable
abstract class CurrentChatState {}

abstract class CurrentChatStateWithChat extends CurrentChatState {
  final GroupchatEntity currentChat;
  CurrentChatStateWithChat({required this.currentChat});
}

class CurrentChatInitial extends CurrentChatState {}

class CurrentChatLoading extends CurrentChatState {}

class CurrentChatEditing extends CurrentChatStateWithChat {
  CurrentChatEditing({required super.currentChat});
}

class CurrentChatError extends CurrentChatState {
  final String title;
  final String message;

  CurrentChatError({
    required this.message,
    required this.title,
  });
}

class CurrentChatLoaded extends CurrentChatStateWithChat {
  CurrentChatLoaded({required super.currentChat});
}
