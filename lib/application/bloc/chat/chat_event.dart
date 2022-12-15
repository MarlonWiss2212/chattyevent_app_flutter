part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class ChatRequestEvent extends ChatEvent {}

class ChatCreateEvent extends ChatEvent {
  final CreateGroupchatDto createGroupchatDto;
  ChatCreateEvent({required this.createGroupchatDto});
}
