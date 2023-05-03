part of 'add_groupchat_cubit.dart';

enum AddGroupchatStateStatus { initial, loading, success }

class AddGroupchatState {
  final GroupchatEntity? addedChat;
  final AddGroupchatStateStatus status;

  final String? title;
  final File? profileImage;
  final String? description;
  final List<CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity>
      groupchatUsers;

  AddGroupchatState({
    this.addedChat,
    this.status = AddGroupchatStateStatus.initial,
    this.title,
    this.profileImage,
    this.description,
    required this.groupchatUsers,
  });
}
