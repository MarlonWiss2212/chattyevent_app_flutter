import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_bought_amount_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/bought_amount_repository.dart';

class BoughtAmountUseCases {
  final BoughtAmountRepository boughtAmountRepository;
  BoughtAmountUseCases({required this.boughtAmountRepository});

  Future<Either<Failure, BoughtAmountEntity>> createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  }) async {
    return await boughtAmountRepository.createBoughtAmountViaApi(
      createBoughtAmountDto: createBoughtAmountDto,
    );
  }

  Future<Either<Failure, List<BoughtAmountEntity>>> getBoughtAmountViaApi({
    required GetBoughtAmountFilter getBoughtAmountFilter,
  }) async {
    return await boughtAmountRepository.getBoughtAmountViaApi(
      getBoughtAmountFilter: getBoughtAmountFilter,
    );
  }

  Future<Either<Failure, BoughtAmountEntity>> updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  }) async {
    return await boughtAmountRepository.updateBoughtAmountViaApi(
      updateBoughtAmountDto: updateBoughtAmountDto,
      boughtAmountId: boughtAmountId,
    );
  }

  Future<Either<Failure, void>> deleteBoughtAmountViaApi({
    required String boughtAmountId,
  }) async {
    return await boughtAmountRepository.deleteBoughtAmountViaApi(
      boughtAmountId: boughtAmountId,
    );
  }
}
