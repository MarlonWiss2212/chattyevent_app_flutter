import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_item_filter.dart';

abstract class ShoppingListItemRepository {
  Future<Either<Failure, ShoppingListItemEntity>> createShoppingListItem({
    required CreateShoppingListItemDto createShoppingListItemDto,
  });
  Future<Either<Failure, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  });
  Future<Either<Failure, ShoppingListItemEntity>>
      updateShoppingListItemViaApi();
  Future<Either<Failure, void>> deleteShoppingListItemViaApi();
}
