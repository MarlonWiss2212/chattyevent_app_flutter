import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/bought_amount/create_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/bought_amount/update_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/bought_amount/find_bought_amounts_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/bought_amount/find_one_bought_amount_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';

abstract class BoughtAmountRepository {
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  });
  Future<Either<NotificationAlert, List<BoughtAmountEntity>>>
      getBoughtAmountsViaApi({
    required FindBoughtAmountsFilter findBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  });
  Future<Either<NotificationAlert, bool>> deleteBoughtAmountViaApi({
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  });
}
