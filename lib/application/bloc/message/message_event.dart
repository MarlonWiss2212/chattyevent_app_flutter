part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class GetMessagesEvent extends MessageEvent {
  final GetMessagesFilter getMessagesFilter;
  GetMessagesEvent({required this.getMessagesFilter});
}

class MessageInitialEvent extends MessageEvent {}

class MessageCreateEvent extends MessageEvent {
  final CreateMessageDto createMessageDto;
  MessageCreateEvent({required this.createMessageDto});
}
