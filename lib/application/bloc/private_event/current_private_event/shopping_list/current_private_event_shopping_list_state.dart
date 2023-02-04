part of 'current_private_event_shopping_list_cubit.dart';

@immutable
abstract class CurrentPrivateEventShoppingListState {}

abstract class CurrentPrivateEventShoppingListStateWithShoppingList
    extends CurrentPrivateEventShoppingListState {
  final List<dynamic> shoppingList;
  CurrentPrivateEventShoppingListStateWithShoppingList({
    required this.shoppingList,
  });
}

class CurrentPrivateEventShoppingListInitial
    extends CurrentPrivateEventShoppingListState {}

class CurrentPrivateEventShoppingListLoading
    extends CurrentPrivateEventShoppingListState {}

class CurrentPrivateEventShoppingListEditing
    extends CurrentPrivateEventShoppingListStateWithShoppingList {
  CurrentPrivateEventShoppingListEditing({required super.shoppingList});
}

class CurrentPrivateEventShoppingListError
    extends CurrentPrivateEventShoppingListState {
  final String title;
  final String message;

  CurrentPrivateEventShoppingListError(
      {required this.message, required this.title});
}

class CurrentPrivateEventShoppingListLoaded
    extends CurrentPrivateEventShoppingListStateWithShoppingList {
  CurrentPrivateEventShoppingListLoaded({
    required super.shoppingList,
  });
}
