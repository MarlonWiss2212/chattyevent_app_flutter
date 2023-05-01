import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_bought_amounts_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/bought_amount_repository.dart';

class BoughtAmountUseCases {
  final BoughtAmountRepository boughtAmountRepository;
  BoughtAmountUseCases({required this.boughtAmountRepository});

  Future<Either<NotificationAlert, BoughtAmountEntity>>
      createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  }) async {
    return await boughtAmountRepository.createBoughtAmountViaApi(
      createBoughtAmountDto: createBoughtAmountDto,
    );
  }

  Future<Either<NotificationAlert, List<BoughtAmountEntity>>>
      getBoughtAmountsViaApi({
    required GetBoughtAmountsFilter getBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await boughtAmountRepository.getBoughtAmountsViaApi(
      getBoughtAmountsFilter: getBoughtAmountsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, BoughtAmountEntity>>
      updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  }) async {
    return await boughtAmountRepository.updateBoughtAmountViaApi(
      updateBoughtAmountDto: updateBoughtAmountDto,
      boughtAmountId: boughtAmountId,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteBoughtAmountViaApi({
    required String boughtAmountId,
  }) async {
    return await boughtAmountRepository.deleteBoughtAmountViaApi(
      boughtAmountId: boughtAmountId,
    );
  }
}
