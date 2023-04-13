import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_bought_amounts_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';

abstract class BoughtAmountRepository {
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  });
  Future<Either<NotificationAlert, List<BoughtAmountEntity>>>
      getBoughtAmountsViaApi({
    required GetBoughtAmountsFilter getBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  });
  Future<Either<NotificationAlert, bool>> deleteBoughtAmountViaApi({
    required String boughtAmountId,
  });
}
