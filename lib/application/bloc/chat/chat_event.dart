part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatRequestEvent extends ChatEvent {}

class ChatCreateEvent extends ChatEvent {
  final CreateGroupchatDto createGroupchatDto;
  ChatCreateEvent({required this.createGroupchatDto});
}
