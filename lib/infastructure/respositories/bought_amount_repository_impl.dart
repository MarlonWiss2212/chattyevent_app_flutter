import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_bought_amounts_filter.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/bought_amount_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/bought_amount_model.dart';

class BoughtAmountRepositoryImpl implements BoughtAmountRepository {
  final GraphQlDatasource graphQlDatasource;

  BoughtAmountRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, BoughtAmountEntity>> createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation CreateBoughtAmount(\$input: CreateBoughtAmountInput!) {
          createBoughtAmount(createBoughtAmountInput: \$input) {
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
          "input": createBoughtAmountDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        BoughtAmountModel.fromJson(response.data!['createBoughtAmount']),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BoughtAmountEntity>>> getBoughtAmountsViaApi({
    required GetBoughtAmountsFilter getBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        query FindBoughtAmounts(\$findBoughtAmountsInput: FindBoughtAmountsInput!, \$limitOffsetFilterInput: LimitOffsetFilterInput!) {
          findBoughtAmounts(findBoughtAmountsInput: \$findBoughtAmountsInput, limitOffsetFilterInput: \$limitOffsetFilterInput) {
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
          "findBoughtAmountsInput": getBoughtAmountsFilter.toMap(),
          "limitOffsetFilterInput": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      final List<BoughtAmountEntity> boughtAmounts = [];
      for (final boughtAmount in response.data!["findBoughtAmounts"]) {
        boughtAmounts.add(BoughtAmountModel.fromJson(boughtAmount));
      }
      return Right(boughtAmounts);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BoughtAmountEntity>> updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateBoughtAmount(\$input: UpdateBoughtAmountInput!, \$boughtAmountId: String!) {
          updateBoughtAmount(updateBoughtAmountInput: \$input) {
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
          "input": updateBoughtAmountDto.toMap(),
          "boughtAmountId": boughtAmountId,
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        BoughtAmountModel.fromJson(response.data!['createBoughtAmount']),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBoughtAmountViaApi({
    required String boughtAmountId,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteBoughtAmount(\$boughtAmountId: String!) {
          deleteBoughtAmount(boughtAmountId: \$input)
        }
      """,
        variables: {"boughtAmountId": boughtAmountId},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(response.data!["deleteBoughtAmount"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
