part of 'current_private_event_cubit.dart';

@immutable
abstract class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  final GroupchatEntity groupchat;
  final List<ShoppingListItemEntity> shoppingList;

  const CurrentPrivateEventState({
    required this.privateEvent,
    required this.groupchat,
    required this.shoppingList,
  });
}

class CurrentPrivateEventInitial extends CurrentPrivateEventState {
  const CurrentPrivateEventInitial({
    required super.privateEvent,
    required super.groupchat,
    required super.shoppingList,
  });
}

class CurrentPrivateEventLoading extends CurrentPrivateEventState {
  final bool loadingPrivateEvent;
  final bool loadingGroupchat;
  final bool loadingShoppingList;

  const CurrentPrivateEventLoading({
    required super.privateEvent,
    required super.groupchat,
    required super.shoppingList,
    required this.loadingPrivateEvent,
    required this.loadingGroupchat,
    required this.loadingShoppingList,
  });
}

class CurrentPrivateEventLoadingPrivateEvent extends CurrentPrivateEventState {
  const CurrentPrivateEventLoadingPrivateEvent({
    required super.privateEvent,
    required super.groupchat,
    required super.shoppingList,
  });
}

class CurrentPrivateEventLoadingGroupchat extends CurrentPrivateEventState {
  const CurrentPrivateEventLoadingGroupchat({
    required super.privateEvent,
    required super.groupchat,
    required super.shoppingList,
  });
}

class CurrentPrivateEventError extends CurrentPrivateEventState {
  final String title;
  final String message;

  const CurrentPrivateEventError({
    required super.privateEvent,
    required this.message,
    required this.title,
    required super.groupchat,
    required super.shoppingList,
  });
}

class CurrentPrivateEventLoaded extends CurrentPrivateEventState {
  const CurrentPrivateEventLoaded({
    required super.privateEvent,
    required super.groupchat,
    required super.shoppingList,
  });
}
