import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferencesDatasource sharedPrefrencesDatasource;
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
  Future<void> saveAuthTokenInStorage(String token) {
    return sharedPrefrencesDatasource.saveToStorage("access_token", token);
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
      return Right(response.data!["login"]["access_token"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register(CreateUserDto createUserDto) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation signup(\$input: CreateUserInput!) {
            signup(createUserInput: \$input) {
              access_token
            }
          }
        """,
        variables: {'input': createUserDto.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(response.data!["signup"]["access_token"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> logout() async {
    return await sharedPrefrencesDatasource.deleteFromStorage("access_token");
  }
}
