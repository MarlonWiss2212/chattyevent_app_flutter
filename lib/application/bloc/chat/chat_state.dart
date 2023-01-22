part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatStateLoading extends ChatState {}

class ChatStateError extends ChatState {
  final String title;
  final String message;
  ChatStateError({
    required this.title,
    required this.message,
  });
}

class ChatStateLoaded extends ChatState {
  final List<GroupchatEntity> chats;

  ChatStateLoaded({
    required this.chats,
  });
}
