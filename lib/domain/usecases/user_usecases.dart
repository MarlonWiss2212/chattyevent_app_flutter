import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/create_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_repository.dart';

class UserUseCases {
  final UserRepository userRepository;
  UserUseCases({required this.userRepository});

  Future<Either<NotificationAlert, UserEntity>> createUserViaApi({
    required CreateUserDto createUserDto,
  }) async {
    return await userRepository.createUserViaApi(
      createUserDto: createUserDto,
    );
  }

  Future<Either<NotificationAlert, UserEntity>> getUserViaApi({
    required FindOneUserFilter findOneUserFilter,
    bool currentUser = false,
  }) async {
    return await userRepository.getUserViaApi(
      findOneUserFilter: findOneUserFilter,
      currentUser: currentUser,
    );
  }

  Future<Either<NotificationAlert, List<UserEntity>>> getUsersViaApi({
    required FindUsersFilter findUsersFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await userRepository.getUsersViaApi(
      findUsersFilter: findUsersFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, UserEntity>> updateUserViaApi({
    required UpdateUserDto updateUserDto,
  }) async {
    return await userRepository.updateUserViaApi(
      updateUserDto: updateUserDto,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteUserViaApi() async {
    return await userRepository.deleteUserViaApi();
  }
}
