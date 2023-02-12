part of 'message_cubit.dart';

@immutable
abstract class MessageState {
  final List<MessageEntity> messages;

  const MessageState({
    required this.messages,
  });
}

class MessageInitial extends MessageState {
  MessageInitial() : super(messages: []);
}

class MessageLoading extends MessageState {
  final String? loadingForGroupchatId;
  const MessageLoading({
    required super.messages,
    this.loadingForGroupchatId,
  });
}

class MessageError extends MessageState {
  final String title;
  final String message;

  const MessageError({
    required this.message,
    required this.title,
    required super.messages,
  });
}

class MessageLoaded extends MessageState {
  const MessageLoaded({required super.messages});
}
