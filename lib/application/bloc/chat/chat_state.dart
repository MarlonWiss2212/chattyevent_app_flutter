part of 'chat_cubit.dart';

@immutable
abstract class ChatState {
  final List<GroupchatEntity> chats;
  const ChatState({required this.chats});
}

class ChatInitial extends ChatState {
  ChatInitial() : super(chats: []);
}

class ChatLoading extends ChatState {
  const ChatLoading({required super.chats});
}

class ChatError extends ChatState {
  final String title;
  final String message;
  const ChatError({
    required super.chats,
    required this.title,
    required this.message,
  });
}

class ChatLoaded extends ChatState {
  const ChatLoaded({required super.chats});
}
