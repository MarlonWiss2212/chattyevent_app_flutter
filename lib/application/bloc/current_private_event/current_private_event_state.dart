part of 'current_private_event_cubit.dart';

enum CurrentPrivateEventStateStatus { initial, success, deleted, updated }

class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  final CurrentChatState? chatState;
  final List<CurrentShoppingListItemState> shoppingListItemStates;

  final bool loadingPrivateEvent;
  final bool loadingGroupchat;
  final bool loadingShoppingList;

  final CurrentPrivateEventStateStatus status;

  final List<PrivateEventUserEntity> privateEventUsers;
  final List<PrivateEventLeftUserEntity> privateEventLeftUsers;

  final int currentUserIndex;

  PrivateEventUserEntity? getCurrentPrivateEventUser() {
    if (currentUserIndex != -1) {
      return privateEventUsers[currentUserIndex];
    }
    return null;
  }

  const CurrentPrivateEventState({
    required this.currentUserIndex,
    required this.privateEvent,
    required this.privateEventUsers,
    required this.privateEventLeftUsers,
    required this.shoppingListItemStates,
    required this.loadingShoppingList,
    this.chatState,
    required this.loadingPrivateEvent,
    required this.loadingGroupchat,
    this.status = CurrentPrivateEventStateStatus.initial,
  });
}