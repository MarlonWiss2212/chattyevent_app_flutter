part of 'current_event_cubit.dart';

enum CurrentPrivateEventStateStatus { initial, success, deleted, updated }

class CurrentEventState {
  final EventEntity event;
  final GroupchatEntity? groupchat;
  final List<CurrentShoppingListItemState> shoppingListItemStates;

  final List<MessageEntity> messages;
  final bool loadingMessages;

  final List<RequestEntity> invitations;
  final bool loadingInvitations;

  final bool loadingEvent;
  final bool loadingGroupchat;
  final bool loadingShoppingList;

  final CurrentPrivateEventStateStatus status;

  final List<EventUserEntity> eventUsers;
  final List<EventLeftUserEntity> eventLeftUsers;

  final int currentUserIndex;

  String getLocationQueryForMaps() {
    return "${event.eventLocation?.address?.street} ${event.eventLocation?.address?.housenumber}, ${event.eventLocation?.address?.city}, ${event.eventLocation?.address?.zip}, ${event.eventLocation?.address?.country}";
  }

  EventUserEntity? getCurrentEventUser() {
    if (currentUserIndex != -1) {
      return eventUsers[currentUserIndex];
    }
    return null;
  }

  bool currentUserAllowedWithPermission({
    EventPermissionEnum? permissionCheckValue,
  }) {
    if (currentUserIndex != -1) {
      return eventUsers[currentUserIndex].currentUserAllowedWithPermission(
        permissionCheckValue: permissionCheckValue,
        createdById: event.createdBy,
      );
    }
    return false;
  }

  const CurrentEventState({
    required this.currentUserIndex,
    required this.messages,
    required this.invitations,
    required this.loadingInvitations,
    required this.loadingMessages,
    required this.event,
    required this.eventUsers,
    required this.eventLeftUsers,
    required this.shoppingListItemStates,
    required this.loadingShoppingList,
    this.groupchat,
    required this.loadingEvent,
    required this.loadingGroupchat,
    this.status = CurrentPrivateEventStateStatus.initial,
  });

  factory CurrentEventState.fromEvent({
    required EventEntity event,
  }) {
    return CurrentEventState(
      event: event,
      invitations: [],
      loadingInvitations: false,
      loadingGroupchat: false,
      loadingEvent: false,
      loadingShoppingList: false,
      currentUserIndex: -1,
      eventUsers: [],
      eventLeftUsers: [],
      shoppingListItemStates: [],
      messages: event.latestMessage != null ? [event.latestMessage!] : [],
      loadingMessages: false,
    );
  }
}
