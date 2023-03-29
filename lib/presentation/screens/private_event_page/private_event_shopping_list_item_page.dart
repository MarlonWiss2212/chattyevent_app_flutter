import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/standard_shopping_list_item_page.dart';

class PrivateEventShoppingListItemPage extends StatelessWidget {
  final String shoppingListItemId;
  final ShoppingListItemEntity shoppingListItemToSet;
  final bool loadShoppingListItemFromApiToo;
  final bool setCurrentPrivateEvent;

  const PrivateEventShoppingListItemPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    required this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
    this.setCurrentPrivateEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return StandardShoppingListItemPage(
      shoppingListItemId: shoppingListItemId,
      shoppingListItemToSet: shoppingListItemToSet,
      setCurrentPrivateEvent: setCurrentPrivateEvent,
      loadShoppingListItemFromApiToo: loadShoppingListItemFromApiToo,
    );
  }
}
