part of 'current_private_event_cubit.dart';

enum CurrentPrivateEventStateStatus { initial, success, error }

class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  final GroupchatEntity? groupchat;
  final List<ShoppingListItemEntity> shoppingListItems;

  final bool loadingPrivateEvent;
  final bool loadingGroupchat;
  final bool loadingShoppingList;

  final CurrentPrivateEventStateStatus status;
  final ErrorWithTitleAndMessage? error;

  final List<UserWithPrivateEventUserData> privateEventUsers;

  const CurrentPrivateEventState({
    required this.privateEvent,
    required this.privateEventUsers,
    required this.shoppingListItems,
    required this.loadingShoppingList,
    this.groupchat,
    required this.loadingPrivateEvent,
    required this.loadingGroupchat,
    this.status = CurrentPrivateEventStateStatus.initial,
    this.error,
  });
}
