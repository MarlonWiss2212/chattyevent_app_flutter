part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatError extends ChatState {
  final String title;
  final String message;
  ChatError({
    required this.title,
    required this.message,
  });
}

class ChatLoaded extends ChatState {
  final List<GroupchatEntity> chats;
  ChatLoaded({required this.chats});
}
