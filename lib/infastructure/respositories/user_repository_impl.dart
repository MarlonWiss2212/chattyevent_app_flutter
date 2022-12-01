import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final GraphQlDatasource graphQlDatasource;
  UserRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, UserEntity>> getUserViaApi(
      {String? userId, String? email}) async {
    try {
      Map<String, String> input = {};
      userId != null ? input.addAll({"_id": userId}) : null;
      email != null ? input.addAll({"email": email}) : null;

      final response = await graphQlDatasource.query(
        """
        query FindUser(\$input: FindOneUserInput!) {
          findUser(filter: \$input) {
            _id
            username
            email
          }
        }
        """,
        variables: {"input": input},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(UserModel.fromJson(response.data!["findUser"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersViaApi(
      String? search) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindUsers {
          findUsers {
            _id
            username
          }
        }
        """,
      );
      if (response.hasException) {
        return Left(GeneralFailure());
      }
      final List<UserEntity> users = [];
      for (final user in response.data!["findUsers"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserViaApi() {
    // TODO: implement updateUserViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> deleteUserViaApi() {
    // TODO: implement deleteUserViaApi
    throw UnimplementedError();
  }
}
