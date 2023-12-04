import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/shopping_list_item/find_one_shopping_list_item_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';

/// Repository for handling shopping list item-related functionality.
abstract class ShoppingListItemRepository {
  /// Creates a shopping list item.
  /// Returns a [NotificationAlert] in case of an error or a [ShoppingListItemEntity] when successful.
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      createShoppingListItem({
    required CreateShoppingListItemDto createShoppingListItemDto,
  });

  /// Retrieves shopping list items via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [ShoppingListItemEntity] when successful.
  Future<Either<NotificationAlert, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    required FindShoppingListItemsFilter findShoppingListItemsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Retrieves a shopping list item via API.
  /// Returns a [NotificationAlert] in case of an error or a [ShoppingListItemEntity] when successful.
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      getShoppingListItemViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  });

  /// Updates a shopping list item via API.
  /// Returns a [NotificationAlert] in case of an error or a [ShoppingListItemEntity] when successful.
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  });

  /// Deletes a shopping list item via API.
  /// Returns a [NotificationAlert] in case of an error or a [bool] indicating success.
  Future<Either<NotificationAlert, bool>> deleteShoppingListItemViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  });
}
