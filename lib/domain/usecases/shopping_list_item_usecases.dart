import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_item_filter.dart';
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
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    return await shoppingListItemRepository.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );
  }

  Future<Either<Failure, ShoppingListItemEntity>>
      updateShoppingListItemsViaApi() async {
    return await shoppingListItemRepository.updateShoppingListItemViaApi();
  }

  Future<Either<Failure, void>> deleteShoppingListItemsViaApi() async {
    return await shoppingListItemRepository.deleteShoppingListItemViaApi();
  }
}
