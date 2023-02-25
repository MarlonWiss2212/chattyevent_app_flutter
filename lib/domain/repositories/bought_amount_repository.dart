import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_bought_amount_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';

abstract class BoughtAmountRepository {
  Future<Either<Failure, BoughtAmountEntity>> createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  });
  Future<Either<Failure, List<BoughtAmountEntity>>> getBoughtAmountViaApi({
    required GetBoughtAmountFilter getBoughtAmountFilter,
  });
  Future<Either<Failure, BoughtAmountEntity>> updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  });
  Future<Either<Failure, bool>> deleteBoughtAmountViaApi({
    required String boughtAmountId,
  });
}
