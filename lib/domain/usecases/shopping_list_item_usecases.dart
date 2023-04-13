import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/shopping_list_item_repository.dart';

class ShoppingListItemUseCases {
  final ShoppingListItemRepository shoppingListItemRepository;
  ShoppingListItemUseCases({required this.shoppingListItemRepository});

  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      createShoppingListItemsViaApi({
    required CreateShoppingListItemDto createShoppingListItemDto,
  }) async {
    return await shoppingListItemRepository.createShoppingListItem(
      createShoppingListItemDto: createShoppingListItemDto,
    );
  }

  Future<Either<NotificationAlert, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      getOneShoppingListItemsViaApi({
    required GetOneShoppingListItemFilter getOneShoppingListItemFilter,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemViaApi(
      getOneShoppingListItemFilter: getOneShoppingListItemFilter,
    );
  }

  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      updateShoppingListItemsViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required GetOneShoppingListItemFilter getOneShoppingListItemFilter,
  }) async {
    return await shoppingListItemRepository.updateShoppingListItemViaApi(
      getOneShoppingListItemFilter: getOneShoppingListItemFilter,
      updateShoppingListItemDto: updateShoppingListItemDto,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteShoppingListItemViaApi({
    required String shoppingListItemId,
  }) async {
    return await shoppingListItemRepository.deleteShoppingListItemViaApi(
      shoppingListItemId: shoppingListItemId,
    );
  }
}
