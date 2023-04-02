part of 'current_private_event_cubit.dart';

enum CurrentPrivateEventStateStatus { initial, success, error }

class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  final CurrentChatState? chatState;
  final List<CurrentShoppingListItemState> shoppingListItemStates;

  final bool loadingPrivateEvent;
  final bool loadingGroupchat;
  final bool loadingShoppingList;

  final CurrentPrivateEventStateStatus status;
  final ErrorWithTitleAndMessage? error;

  final List<UserWithPrivateEventUserData> privateEventUsers;

  const CurrentPrivateEventState({
    required this.privateEvent,
    required this.privateEventUsers,
    required this.shoppingListItemStates,
    required this.loadingShoppingList,
    this.chatState,
    required this.loadingPrivateEvent,
    required this.loadingGroupchat,
    this.status = CurrentPrivateEventStateStatus.initial,
    this.error,
  });
}
