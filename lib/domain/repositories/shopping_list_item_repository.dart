import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/shopping_list_item/find_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/core/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/core/response/shopping-list-item-data.response.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';

abstract class ShoppingListItemRepository {
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      createShoppingListItem({
    required CreateShoppingListItemDto createShoppingListItemDto,
  });
  Future<Either<NotificationAlert, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    required FindShoppingListItemsFilter findShoppingListItemsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      getShoppingListItemViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  });
  Future<Either<NotificationAlert, ShoppingListItemDataResponse>>
      getShoppingListItemDataViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
    required LimitOffsetFilter limitOffsetFilterBoughtAmounts,
  });
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  });
  Future<Either<NotificationAlert, bool>> deleteShoppingListItemViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  });
}
