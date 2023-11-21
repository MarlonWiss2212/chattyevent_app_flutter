import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/bought_amount/create_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/bought_amount/update_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/shopping_list_item/bought_amount/find_bought_amounts_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/shopping_list_item/bought_amount/find_one_bought_amount_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/bought_amount_repository.dart';

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
    required FindBoughtAmountsFilter findBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await boughtAmountRepository.getBoughtAmountsViaApi(
      findBoughtAmountsFilter: findBoughtAmountsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, BoughtAmountEntity>>
      updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  }) async {
    return await boughtAmountRepository.updateBoughtAmountViaApi(
      updateBoughtAmountDto: updateBoughtAmountDto,
      findOneBoughtAmountFilter: findOneBoughtAmountFilter,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteBoughtAmountViaApi({
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  }) async {
    return await boughtAmountRepository.deleteBoughtAmountViaApi(
      findOneBoughtAmountFilter: findOneBoughtAmountFilter,
    );
  }
}
