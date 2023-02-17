import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/shopping_list_item_repository.dart';

class ShoppingListItemUseCases {
  final ShoppingListItemRepository shoppingListItemRepository;
  ShoppingListItemUseCases({required this.shoppingListItemRepository});

  Future<Either<Failure, ShoppingListItemEntity>>
      createShoppingListItemsViaApi({
    required CreateShoppingListItemDto createShoppingListItemDto,
  }) async {
    return await shoppingListItemRepository.createShoppingListItem(
      createShoppingListItemDto: createShoppingListItemDto,
    );
  }

  Future<Either<Failure, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    GetShoppingListItemsFilter? getShoppingListItemsFilter,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );
  }

  Future<Either<Failure, ShoppingListItemEntity>>
      updateShoppingListItemsViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required String shoppingListItemId,
  }) async {
    return await shoppingListItemRepository.updateShoppingListItemViaApi(
      shoppingListItemId: shoppingListItemId,
      updateShoppingListItemDto: updateShoppingListItemDto,
    );
  }

  Future<Either<Failure, void>> deleteShoppingListItemsViaApi() async {
    return await shoppingListItemRepository.deleteShoppingListItemViaApi();
  }
}
