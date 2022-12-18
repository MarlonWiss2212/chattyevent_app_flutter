part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class ChatRequestEvent extends ChatEvent {}

class GetOneChatEvent extends ChatEvent {
  final GetOneGroupchatFilter getOneGroupchatFilter;

  GetOneChatEvent({required this.getOneGroupchatFilter});
}

class ChatCreateEvent extends ChatEvent {
  final CreateGroupchatDto createGroupchatDto;
  ChatCreateEvent({required this.createGroupchatDto});
}
