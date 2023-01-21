part of 'current_chat_cubit.dart';

@immutable
abstract class CurrentChatState {}

class CurrentChatInitial extends CurrentChatState {}

class CurrentChatLoading extends CurrentChatState {}

class CurrentChatEditing extends CurrentChatState {}

class CurrentChatError extends CurrentChatState {
  final String title;
  final String message;

  CurrentChatError({required this.message, required this.title});
}

class CurrentChatLoaded extends CurrentChatState {}
