part of 'add_chat_cubit.dart';

@immutable
abstract class AddChatState {}

class AddChatInitial extends AddChatState {}

class AddChatLoading extends AddChatState {}

class AddChatError extends AddChatState {
  String title;
  String message;

  AddChatError({required this.message, required this.title});
}

class AddChatLoaded extends AddChatState {
  final GroupchatEntity addedChat;
  AddChatLoaded({required this.addedChat});
}
