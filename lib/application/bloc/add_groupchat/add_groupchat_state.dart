part of 'add_groupchat_cubit.dart';

enum AddGroupchatStateStatus { initial, loading, success }

class AddGroupchatState {
  final GroupchatEntity? addedChat;
  final String subtitle;
  final AddGroupchatStateStatus status;

  final String? title;
  final File? profileImage;
  final CreateGroupchatPermissionsDto permissions;
  final String? description;
  final List<CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity>
      groupchatUsers;

  AddGroupchatState({
    required this.subtitle,
    this.addedChat,
    this.status = AddGroupchatStateStatus.initial,
    this.title,
    required this.permissions,
    this.profileImage,
    this.description,
    required this.groupchatUsers,
  });
}
