import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';

class ShoppingListItemDataResponse {
  final ShoppingListItemEntity shoppingListItem;
  final List<BoughtAmountEntity> boughtAmounts;

  ShoppingListItemDataResponse({
    required this.shoppingListItem,
    required this.boughtAmounts,
  });
}
