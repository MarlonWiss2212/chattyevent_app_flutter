part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageStateLoading extends MessageState {}

class MessageStateError extends MessageState {
  final String message;
  MessageStateError({required this.message});
}

class MessageStateLoaded extends MessageState {
  final List<MessageEntity> messages;
  MessageStateLoaded({required this.messages});
}
