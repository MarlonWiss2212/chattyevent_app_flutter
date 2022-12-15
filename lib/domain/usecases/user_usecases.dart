import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';

class UserUseCases {
  final UserRepository userProfileRepository;
  UserUseCases({required this.userProfileRepository});

  Future<Either<Failure, UserEntity>> getUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    return await userProfileRepository.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );
  }

  Future<Either<Failure, List<UserEntity>>> getUsersViaApi(
      String? search) async {
    return await userProfileRepository.getUsersViaApi(search);
  }
}
