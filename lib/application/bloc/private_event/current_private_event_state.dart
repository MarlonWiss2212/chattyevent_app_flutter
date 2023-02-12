part of 'current_private_event_cubit.dart';

@immutable
abstract class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  final GroupchatEntity groupchat;
  final List<ShoppingListItemEntity> shoppingList;

  final List<UserWithPrivateEventUserData> privateEventUsers;

  final bool loadingPrivateEvent;
  final bool loadingGroupchat;
  final bool loadingShoppingList;

  const CurrentPrivateEventState({
    required this.privateEvent,
    required this.privateEventUsers,
    required this.groupchat,
    required this.shoppingList,
    required this.loadingPrivateEvent,
    required this.loadingGroupchat,
    required this.loadingShoppingList,
  });
}

class CurrentPrivateEventNormal extends CurrentPrivateEventState {
  const CurrentPrivateEventNormal({
    required super.privateEventUsers,
    required super.privateEvent,
    required super.groupchat,
    required super.shoppingList,
    required super.loadingGroupchat,
    required super.loadingPrivateEvent,
    required super.loadingShoppingList,
  });
}

class CurrentPrivateEventError extends CurrentPrivateEventState {
  final String title;
  final String message;

  const CurrentPrivateEventError({
    required super.privateEventUsers,
    required super.privateEvent,
    required this.message,
    required this.title,
    required super.groupchat,
    required super.shoppingList,
    required super.loadingGroupchat,
    required super.loadingPrivateEvent,
    required super.loadingShoppingList,
  });
}