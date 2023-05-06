import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/shopping_list_item/bought_amount/find_bought_amounts_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/shopping_list_item/find_one_shopping_list_item_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/core/response/shopping-list-item-data.response.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/shopping_list_item_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/bought_amount_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/shopping_list_item_model.dart';

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
          response: response,
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
    required FindShoppingListItemsFilter findShoppingListItemsFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItems(\$filter: FindShoppingListItemsInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findShoppingListItems(filter: \$filter, limitOffsetInput: \$limitOffsetInput) {
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
          "filter": findShoppingListItemsFilter.toMap(),
          "limitOffsetInput": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Items Fehler",
          response: response,
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
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItem(\$filter: FindOneShoppingListItemInput!) {
          findShoppingListItem(filter: \$filter) {
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
          "filter": findOneShoppingListItemFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Item Fehler",
          response: response,
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
  Future<Either<NotificationAlert, ShoppingListItemDataResponse>>
      getShoppingListItemDataViaApi({
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
    required LimitOffsetFilter limitOffsetFilterBoughtAmounts,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindShoppingListItem(\$filter: FindOneShoppingListItemInput!, \$findBoughtAmountsInput: FindBoughtAmountsInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findShoppingListItem(filter: \$filter) {
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
          
          findBoughtAmounts(filter: \$findBoughtAmountsInput, limitOffsetInput: \$limitOffsetInput) {
            _id
            boughtAmount
            shoppingListItemId
            createdAt
            updatedAt
            createdBy
          }
        }
      """,
        variables: {
          "filter": findOneShoppingListItemFilter.toMap(),
          "findBoughtAmountsInput": FindBoughtAmountsFilter(
            shoppingListItemId:
                findOneShoppingListItemFilter.shoppingListItemId,
          ).toMap(),
          "limitOffsetInput": limitOffsetFilterBoughtAmounts.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Item Daten Fehler",
          response: response,
        ));
      }

      final List<BoughtAmountEntity> boughtAmounts = [];
      for (final boughtAmount in response.data!["findBoughtAmounts"]) {
        boughtAmounts.add(BoughtAmountModel.fromJson(boughtAmount));
      }

      return Right(ShoppingListItemDataResponse(
        shoppingListItem: ShoppingListItemModel.fromJson(
          response.data!["findShoppingListItem"],
        ),
        boughtAmounts: boughtAmounts,
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, ShoppingListItemEntity>>
      updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateShoppingListItem(\$updateShoppingListItemInput: UpdateShoppingListItemInput!, \$filter: FindOneShoppingListItemInput!) {
          updateShoppingListItem(updateShoppingListItemInput: \$updateShoppingListItemInput, filter: \$filter) {
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
          "updateShoppingListItemInput": updateShoppingListItemDto.toMap(),
          "filter": findOneShoppingListItemFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Item Fehler",
          response: response,
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
    required FindOneShoppingListItemFilter findOneShoppingListItemFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeleteShoppingListItem(\$filter: FindOneShoppingListItemInput!) {
            deleteShoppingListItem(filter: \$filter)
          }
        """,
        variables: {"filter": findOneShoppingListItemFilter},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Löschen Item Fehler",
          response: response,
        ));
      }

      return Right(response.data!["deleteShoppingListItem"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
