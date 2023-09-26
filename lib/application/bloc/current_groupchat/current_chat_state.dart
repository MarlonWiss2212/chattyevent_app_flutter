part of 'current_chat_cubit.dart';

class CurrentGroupchatState {
  final GroupchatEntity currentChat;
  final int currentUserIndex;

  final List<GroupchatUserEntity> users;
  final List<GroupchatLeftUserEntity> leftUsers;

  final List<MessageEntity> messages;
  final List<RequestEntity> invitations;

  //TODO
  //final List<GroupchatUser> requests;

  final List<EventEntity> futureConnectedPrivateEvents;
  final bool loadingPrivateEvents;

  final bool currentUserLeftChat;

  final bool loadingChat;
  final bool loadingMessages;
  final bool loadingInvitations;

  GroupchatUserEntity? getCurrentGroupchatUser() {
    if (currentUserIndex != -1) {
      return users[currentUserIndex];
    }
    return null;
  }

  bool currentUserAllowedWithPermission({
    GroupchatPermissionEnum? permissionCheckValue,
  }) {
    if (currentUserIndex != -1) {
      return users[currentUserIndex].currentUserAllowedWithPermission(
        permissionCheckValue: permissionCheckValue,
      );
    }
    return false;
  }

  const CurrentGroupchatState({
    required this.invitations,
    required this.loadingInvitations,
    required this.currentUserIndex,
    required this.currentUserLeftChat,
    required this.loadingPrivateEvents,
    required this.futureConnectedPrivateEvents,
    required this.loadingMessages,
    required this.messages,
    required this.currentChat,
    required this.loadingChat,
    required this.users,
    required this.leftUsers,
  });

  factory CurrentGroupchatState.fromGroupchat({
    required GroupchatEntity groupchat,
  }) {
    return CurrentGroupchatState(
      currentChat: groupchat,
      messages:
          groupchat.latestMessage != null ? [groupchat.latestMessage!] : [],
      loadingInvitations: false,
      invitations: [],
      currentUserIndex: -1,
      currentUserLeftChat: false,
      futureConnectedPrivateEvents: [],
      loadingChat: false,
      leftUsers: [],
      loadingMessages: false,
      loadingPrivateEvents: false,
      users: [],
    );
  }

  factory CurrentGroupchatState.merge({
    required CurrentGroupchatState oldState,
    required String currentUserId,
    bool? loadingInvitations,
    GroupchatEntity? currentChat,
    List<GroupchatUserEntity>? users,
    List<GroupchatLeftUserEntity>? leftUsers,
    List<EventEntity>? futureConnectedPrivateEvents,
    List<MessageEntity>? messages,
    List<RequestEntity>? invitations,
    bool? loadingPrivateEvents,
    bool? currentUserLeftChat,
    bool? loadingChat,
    bool? loadingMessages,
  }) {
    final List<MessageEntity> allMessages = messages ?? oldState.messages;
    allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final List<RequestEntity> allInvitations =
        invitations ?? oldState.invitations;
    allInvitations.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    GroupchatEntity newChat = currentChat ?? oldState.currentChat;
    allMessages.isNotEmpty
        ? newChat = GroupchatEntity.merge(
            newEntity: GroupchatEntity(
              id: newChat.id,
              latestMessage: allMessages.first,
            ),
            oldEntity: newChat,
          )
        : null;

    final newUsers = users ?? oldState.users;

    return CurrentGroupchatState(
      invitations: allInvitations,
      loadingInvitations: loadingInvitations ?? oldState.loadingInvitations,
      messages: allMessages,
      currentUserIndex: newUsers.indexWhere(
        (element) => element.id == currentUserId,
      ),
      currentUserLeftChat: currentUserLeftChat ?? oldState.currentUserLeftChat,
      loadingPrivateEvents:
          loadingPrivateEvents ?? oldState.loadingPrivateEvents,
      futureConnectedPrivateEvents:
          futureConnectedPrivateEvents ?? oldState.futureConnectedPrivateEvents,
      loadingMessages: loadingMessages ?? oldState.loadingMessages,
      currentChat: newChat,
      loadingChat: loadingChat ?? oldState.loadingChat,
      users: newUsers,
      leftUsers: leftUsers ?? oldState.leftUsers,
    );
  }
}
