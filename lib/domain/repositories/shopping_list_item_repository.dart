import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';

abstract class ShoppingListItemRepository {
  Future<Either<Failure, ShoppingListItemEntity>> createShoppingListItem({
    required CreateShoppingListItemDto createShoppingListItemDto,
  });
  Future<Either<Failure, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    GetShoppingListItemsFilter? getShoppingListItemsFilter,
  });
  Future<Either<Failure, ShoppingListItemEntity>> updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required String shoppingListItemId,
  });
  Future<Either<Failure, void>> deleteShoppingListItemViaApi();
}
