import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/bought_amount/find_bought_amounts_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/bought_amount/find_one_bought_amount_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/bought_amount/update_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/bought_amount/create_bought_amount_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/bought_amount_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/bought_amount_model.dart';

class BoughtAmountRepositoryImpl implements BoughtAmountRepository {
  final GraphQlDatasource graphQlDatasource;
  BoughtAmountRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation CreateBoughtAmount(\$input: CreateBoughtAmountInput!) {
          createBoughtAmount(createBoughtAmountInput: \$input) {
            _id
            boughtAmount
            shoppingListItemTo
            createdAt
            updatedAt
            createdBy
          }
        }
      """,
        variables: {
          "input": createBoughtAmountDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen gekaufte Menge Fehler",
          response: response,
        ));
      }

      return Right(
        BoughtAmountModel.fromJson(response.data!['createBoughtAmount']),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<BoughtAmountEntity>>>
      getBoughtAmountsViaApi({
    required FindBoughtAmountsFilter findBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        query FindBoughtAmounts(\$filter: FindBoughtAmountsInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findBoughtAmounts(filter: \$filter, limitOffsetInput: \$limitOffsetInput) {
            _id
            boughtAmount
            shoppingListItemTo
            createdAt
            updatedAt
            createdBy
          }
        }
      """,
        variables: {
          "filter": findBoughtAmountsFilter.toMap(),
          "limitOffsetInput": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Holen gekaufte Menge Fehler",
          response: response,
        ));
      }

      final List<BoughtAmountEntity> boughtAmounts = [];
      for (final boughtAmount in response.data!["findBoughtAmounts"]) {
        boughtAmounts.add(BoughtAmountModel.fromJson(boughtAmount));
      }
      return Right(boughtAmounts);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateBoughtAmount(\$input: UpdateBoughtAmountInput!, \$filter: FindOneBoughtAmountInput!) {
          updateBoughtAmount(updateBoughtAmountInput: \$input, filter: filter) {
            _id
            boughtAmount
            shoppingListItemTo
            createdAt
            updatedAt
            createdBy
          }
        }
      """,
        variables: {
          "input": updateBoughtAmountDto.toMap(),
          "filter": findOneBoughtAmountFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten gekaufte Menge Fehler",
          response: response,
        ));
      }

      return Right(
        BoughtAmountModel.fromJson(response.data!['createBoughtAmount']),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deleteBoughtAmountViaApi({
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteBoughtAmount(\$filter: FindOneBoughtAmountInput!) {
          deleteBoughtAmount(filter: \$filter)
        }
      """,
        variables: {
          "filter": findOneBoughtAmountFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Löschen gekaufte Menge Fehler",
          response: response,
        ));
      }

      return Right(response.data!["deleteBoughtAmount"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
