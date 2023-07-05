import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/create_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<Either<NotificationAlert, UserEntity>> createUserViaApi({
    required CreateUserDto createUserDto,
  });
  Future<Either<NotificationAlert, UserEntity>> getUserViaApi({
    required FindOneUserFilter findOneUserFilter,
    required bool currentUser,
  });
  Future<Either<NotificationAlert, List<UserEntity>>> getUsersViaApi({
    required FindUsersFilter findUsersFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, UserEntity>> updateUserViaApi({
    required UpdateUserDto updateUserDto,
  });
  Future<Either<NotificationAlert, bool>> deleteUserViaApi();
}
