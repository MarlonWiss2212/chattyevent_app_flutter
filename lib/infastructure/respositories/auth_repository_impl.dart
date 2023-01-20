import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_and_token_entity.dart.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:social_media_app_flutter/infastructure/models/user_and_token_model.dart';

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
  Future<Either<Failure, UserAndTokenEntity>> login(
      String email, String password) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation Login(\$input: LoginUserInput!) {
            login(loginUserInput: \$input) {
              access_token
              user {
                _id
                firstname
                lastname
                username
                profileImageLink
                email
              }
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
      return Right(UserAndTokenModel.fromJson(response.data!["login"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserAndTokenEntity>> register(
      CreateUserDto createUserDto) async {
    try {
      Map<String, dynamic> variables = {
        "input": createUserDto.toMap(),
      };
      if (createUserDto.profileImage != null) {
        final byteData = createUserDto.profileImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename:
              '${createUserDto.firstname}${createUserDto.lastname}${createUserDto.username}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'profileImage': multipartFile});
      }
      final response = await graphQlDatasource.mutation(
        """
          mutation signup(\$input: CreateUserInput!, \$profileImage: Upload) {
            signup(createUserInput: \$input, profileImage: \$profileImage) {
              access_token
              user {
                _id
                firstname
                lastname
                username
                profileImageLink
                email
              }
            }
          }
        """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(UserAndTokenModel.fromJson(response.data!["signup"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> logout() async {
    return await sharedPrefrencesDatasource.deleteFromStorage("access_token");
  }
}
