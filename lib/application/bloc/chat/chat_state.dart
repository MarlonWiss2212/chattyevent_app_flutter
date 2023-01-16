part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatStateLoading extends ChatState {}

class ChatStateError extends ChatState {
  final String message;
  ChatStateError({required this.message});
}

class ChatStateLoaded extends ChatState {
  final List<GroupchatEntity> chats;
  final String? errorMessage;

  ChatStateLoaded({
    required this.chats,
    this.errorMessage,
  });
}
