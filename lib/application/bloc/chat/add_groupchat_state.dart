part of 'add_groupchat_cubit.dart';

enum AddChatStateStatus { initial, loading, success, error }

class AddGroupchatState {
  final GroupchatEntity? addedChat;
  final ErrorWithTitleAndMessage? error;
  final CreateGroupchatDto createGroupchatDto;
  final AddChatStateStatus status;

  AddGroupchatState({
    this.addedChat,
    this.error,
    this.status = AddChatStateStatus.initial,
    required this.createGroupchatDto,
  });
}
