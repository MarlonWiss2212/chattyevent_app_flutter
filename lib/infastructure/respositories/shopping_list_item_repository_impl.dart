import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/utils/failure_helper.dart';
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
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      createShoppingListItem({
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
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen Item Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        ShoppingListItemModel.fromJson(
          response.data!['createShoppingListItem'],
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<ShoppingListItemEntity>>>
      getShoppingListItemsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItems(\$input: FindShoppingListItemsInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findShoppingListItems(findShoppingListItemsInput: \$input, limitOffsetInput: \$limitOffsetInput) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount
            userToBuyItem
            privateEventId
            createdBy
          }
        }
      """,
        variables: {
          "input": getShoppingListItemsFilter.toMap(),
          "limitOffsetInput": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Items Fehler",
          exception: response.exception!,
        ));
      }
      final List<ShoppingListItemEntity> shoppingListItems = [];
      for (var shoppingListItem in response.data!["findShoppingListItems"]) {
        shoppingListItems.add(ShoppingListItemModel.fromJson(shoppingListItem));
      }
      return Right(shoppingListItems);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      getShoppingListItemViaApi({
    required GetOneShoppingListItemFilter getOneShoppingListItemFilter,
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
            boughtAmount
            userToBuyItem
            privateEventId
            createdBy
          }
        }
      """,
        variables: {
          "input": getOneShoppingListItemFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Item Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        ShoppingListItemModel.fromJson(response.data!["findShoppingListItem"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required GetOneShoppingListItemFilter getOneShoppingListItemFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateShoppingListItem(\$input: UpdateShoppingListItemInput!, \$filter: FindOneShoppingListItemInput!) {
          updateShoppingListItem(updateShoppingListItemInput: \$input, filter: \$filter) {
            _id
            createdAt
            updatedAt
            itemName
            unit
            amount
            boughtAmount
            userToBuyItem
            privateEventId
            createdBy
          }
        }
      """,
        variables: {
          "input": updateShoppingListItemDto.toMap(),
          "filter": getOneShoppingListItemFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Item Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        ShoppingListItemModel.fromJson(
          response.data!['updateShoppingListItem'],
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deleteShoppingListItemViaApi({
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
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Löschen Item Fehler",
          exception: response.exception!,
        ));
      }

      return Right(response.data!["deleteShoppingListItem"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
