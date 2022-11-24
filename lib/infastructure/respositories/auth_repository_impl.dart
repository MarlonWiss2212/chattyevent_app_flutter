import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/graphql.dart';
import 'package:social_media_app_flutter/infastructure/datasources/sharedPrefrences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPrefrencesDatasource sharedPrefrencesDatasource;
  final GraphQlDatasource graphQlDatasource;

  AuthRepositoryImpl({
    required this.sharedPrefrencesDatasource,
    required this.graphQlDatasource,
  });

  @override
  Future<Either<Failure, String>> getAuthTokenFromStorage() async {
    try {
      return await sharedPrefrencesDatasource.getFromStorage("access_token");
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation Login(\$input: LoginUserInput!) {
            login(loginUserInput: \$input) {
              access_token
            }
          }
        """,
        variables: {
          "input": {
            'email': email,
            'password': password,
          }
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      await sharedPrefrencesDatasource.saveToStorage(
        "access_token",
        response.data!["login"]["access_token"],
      );
      return Right(response.data!["login"]["access_token"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register(
      String email, String password) async {
    throw UnimplementedError();
  }
}
