part of 'edit_chat_cubit.dart';

@immutable
abstract class EditChatState {}

class EditChatInitial extends EditChatState {}

class EditChatLoading extends EditChatState {}

class EditChatError extends EditChatState {
  final String title;
  final String message;

  EditChatError({required this.message, required this.title});
}

class EditChatLoaded extends EditChatState {
  final GroupchatEntity editedChat;
  EditChatLoaded({required this.editedChat});
}
