import 'package:social_media_app_flutter/domain/filter/get_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/dto/create_shopping_list_item_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/shopping_list_item_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/shopping_list_item_model.dart';

class ShoppingListItemRepositoryImpl implements ShoppingListItemRepository {
  final GraphQlDatasource graphQlDatasource;
  ShoppingListItemRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, ShoppingListItemEntity>> createShoppingListItem({
    required CreateShoppingListItemDto createShoppingListItemDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation CreateShoppingListItem(\$input: CreateShoppingListItemInput!) {
          createShoppingListItem(createShoppingListItemInput: \$input) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount
            userToBuyItem
            privateEvent
            createdBy
          }
        }
      """,
        variables: {
          "input": createShoppingListItemDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        ShoppingListItemModel.fromJson(
          response.data!['createShoppingListItem'],
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItems(\$input: FindShoppingListItemsInput!) {
          findShoppingListItems(findShoppingListItemsInput: \$input) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount
            userToBuyItem
            privateEvent
            createdBy
          }
        }
      """,
        variables: {
          "input": getShoppingListItemsFilter.toMap(),
        },
      );

      if (response.hasException) {
        print(response.exception);
        return Left(GeneralFailure());
      }

      final List<ShoppingListItemEntity> shoppingListItems = [];
      for (var shoppingListItem in response.data!["findShoppingListItems"]) {
        shoppingListItems.add(ShoppingListItemModel.fromJson(shoppingListItem));
      }
      return Right(shoppingListItems);
    } catch (e) {
      print(e);

      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ShoppingListItemEntity>>
      updateShoppingListItemViaApi() {
    // TODO: implement updateShoppingListItemViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteShoppingListItemViaApi() {
    // TODO: implement deleteShoppingListItemViaApi
    throw UnimplementedError();
  }
}
