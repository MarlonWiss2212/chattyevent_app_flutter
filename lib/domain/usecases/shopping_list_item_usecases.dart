import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/shopping_list_item/find_one_shopping_list_item_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/core/response/shopping-list-item-data.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/shopping_list_item_repository.dart';

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
    required FindShoppingListItemsFilter findShoppingListItemsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemsViaApi(
      findShoppingListItemsFilter: findShoppingListItemsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      getOneShoppingListItemsViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemViaApi(
      findOneShoppingListItemFilter: findOneShoppingListItemFilter,
    );
  }

  Future<Either<NotificationAlert, ShoppingListItemDataResponse>>
      getShoppingListItemDataViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
    required LimitOffsetFilter limitOffsetFilterBoughtAmounts,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemDataViaApi(
      findOneShoppingListItemFilter: findOneShoppingListItemFilter,
      limitOffsetFilterBoughtAmounts: limitOffsetFilterBoughtAmounts,
    );
  }

  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      updateShoppingListItemsViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  }) async {
    return await shoppingListItemRepository.updateShoppingListItemViaApi(
      findOneShoppingListItemFilter: findOneShoppingListItemFilter,
      updateShoppingListItemDto: updateShoppingListItemDto,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteShoppingListItemViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  }) async {
    return await shoppingListItemRepository.deleteShoppingListItemViaApi(
      findOneShoppingListItemFilter: findOneShoppingListItemFilter,
    );
  }
}
