part of 'chat_bloc.dart';

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
  final String? createdEventId;

  ChatStateLoaded({
    required this.chats,
    this.errorMessage,
    this.createdEventId,
  });
}
