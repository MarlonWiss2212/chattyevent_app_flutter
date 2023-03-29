import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
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
            boughtAmount {
              _id
              boughtAmount
              shoppingListItemId
              createdAt
              updatedAt
              createdBy
            }
            userToBuyItem
            privateEventId
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
    required LimitOffsetFilter limitOffsetFilter,
    GetShoppingListItemsFilter? getShoppingListItemsFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItems(\$input: FindShoppingListItemsInput, \$limitOffsetFilterInput: LimitOffsetFilterInput!) {
          findShoppingListItems(findShoppingListItemsInput: \$input, limitOffsetFilterInput: \$limitOffsetFilterInput) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount {
              _id
              boughtAmount
              shoppingListItemId
              createdAt
              updatedAt
              createdBy
            }
            userToBuyItem
            privateEventId
            createdBy
          }
        }
      """,
        variables: {
          "input": getShoppingListItemsFilter?.toMap(),
          "limitOffsetFilterInput": limitOffsetFilter.toMap(),
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
  Future<Either<Failure, ShoppingListItemEntity>> getShoppingListItemViaApi({
    required GetOneShoppingListItemsFilter getOneShoppingListItemsFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItem(\$input: FindOneShoppingListItemInput!) {
          findShoppingListItem(filter: \$input) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount {
              _id
              boughtAmount
              shoppingListItemId
              createdAt
              updatedAt
              createdBy
            }
            userToBuyItem
            privateEventId
            createdBy
          }
        }
      """,
        variables: {
          "input": getOneShoppingListItemsFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        ShoppingListItemModel.fromJson(response.data!["findShoppingListItem"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ShoppingListItemEntity>> updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required String shoppingListItemId,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateShoppingListItem(\$input: UpdateShoppingListItemInput!, \$shoppingListItemId: String!) {
          updateShoppingListItem(updateShoppingListItemInput: \$input, shoppingListItemId: \$shoppingListItemId) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount {
              _id
              boughtAmount
              shoppingListItemId
              createdAt
              updatedAt
              createdBy
            }
            userToBuyItem
            privateEventId
            createdBy
          }
        }
      """,
        variables: {
          "input": updateShoppingListItemDto.toMap(),
          "shoppingListItemId": shoppingListItemId,
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        ShoppingListItemModel.fromJson(
          response.data!['updateShoppingListItem'],
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteShoppingListItemViaApi({
    required String shoppingListItemId,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeleteShoppingListItem(\$shoppingListItemId: String!) {
            deleteShoppingListItem(shoppingListItemId: \$shoppingListItemId)
          }
        """,
        variables: {"shoppingListItemId": shoppingListItemId},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(response.data!["deleteShoppingListItem"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
