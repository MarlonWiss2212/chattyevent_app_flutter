import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/standard_shopping_list_item_page.dart';

class PrivateEventShoppingListItemPage extends StatelessWidget {
  final String shoppingListItemId;
  final CurrentShoppingListItemState shoppingListItemStateToSet;
  final bool loadShoppingListItemFromApiToo;
  final bool setCurrentPrivateEvent;

  const PrivateEventShoppingListItemPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.loadShoppingListItemFromApiToo = true,
    this.setCurrentPrivateEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return StandardShoppingListItemPage(
      shoppingListItemId: shoppingListItemId,
      shoppingListItemStateToSet: shoppingListItemStateToSet,
      setCurrentPrivateEvent: setCurrentPrivateEvent,
    );
  }
}
