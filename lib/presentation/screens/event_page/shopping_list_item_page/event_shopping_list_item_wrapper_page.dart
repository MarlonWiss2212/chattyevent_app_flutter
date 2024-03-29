import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/standard_shopping_list_item_page/standard_shopping_list_item_wrapper_page.dart';

@RoutePage()
class EventShoppingListItemWrapperPage extends StatelessWidget {
  final String shoppingListItemId;
  final CurrentShoppingListItemState shoppingListItemStateToSet;
  final bool setCurrentPrivateEvent;

  const EventShoppingListItemWrapperPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.setCurrentPrivateEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return StandardShoppingListItemWrapperPage(
      shoppingListItemId: shoppingListItemId,
      shoppingListItemStateToSet: shoppingListItemStateToSet,
      setCurrentPrivateEvent: setCurrentPrivateEvent,
    );
  }
}
