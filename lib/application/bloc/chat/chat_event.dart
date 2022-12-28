part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class GetChatsEvent extends ChatEvent {}

class GetOneChatEvent extends ChatEvent {
  final GetOneGroupchatFilter getOneGroupchatFilter;

  GetOneChatEvent({required this.getOneGroupchatFilter});
}

class CreateChatEvent extends ChatEvent {
  final CreateGroupchatDto createGroupchatDto;
  CreateChatEvent({required this.createGroupchatDto});
}

class AddUserToChatEvent extends ChatEvent {
  final String groupchatId;
  final String userIdToAdd;
  AddUserToChatEvent({required this.groupchatId, required this.userIdToAdd});
}

class DeleteUserFromChatEvent extends ChatEvent {
  final String groupchatId;
  final String userIdToDelete;
  DeleteUserFromChatEvent({
    required this.groupchatId,
    required this.userIdToDelete,
  });
}
