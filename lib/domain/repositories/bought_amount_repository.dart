import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/bought_amount/create_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/bought_amount/update_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/shopping_list_item/bought_amount/find_bought_amounts_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/shopping_list_item/bought_amount/find_one_bought_amount_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';

/// Repository for handling bought amounts via API.
abstract class BoughtAmountRepository {
  /// Creates a bought amount via API.
  /// Returns a [NotificationAlert] in case of an error or a [BoughtAmountEntity] when successful.
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      createBoughtAmountViaApi({
    required CreateBoughtAmountDto createBoughtAmountDto,
  });

  /// Retrieves bought amounts via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [BoughtAmountEntity] when successful.
  Future<Either<NotificationAlert, List<BoughtAmountEntity>>>
      getBoughtAmountsViaApi({
    required FindBoughtAmountsFilter findBoughtAmountsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Updates a bought amount via API.
  /// Returns a [NotificationAlert] in case of an error or a [BoughtAmountEntity] when successful.
  Future<Either<NotificationAlert, BoughtAmountEntity>>
      updateBoughtAmountViaApi({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  });

  /// Deletes a bought amount via API.
  /// Returns a [NotificationAlert] in case of an error or a boolean indicating success.
  Future<Either<NotificationAlert, bool>> deleteBoughtAmountViaApi({
    required FindOneBoughtAmountFilter findOneBoughtAmountFilter,
  });
}
