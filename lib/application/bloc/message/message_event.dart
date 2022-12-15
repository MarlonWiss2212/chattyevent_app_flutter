part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class MessageRequestEvent extends MessageEvent {
  final GetMessagesFilter getMessagesFilter;
  MessageRequestEvent({required this.getMessagesFilter});
}

class MessageInitialEvent extends MessageEvent {}

class MessageCreateEvent extends MessageEvent {
  final CreateMessageDto createMessageDto;
  MessageCreateEvent({required this.createMessageDto});
}
