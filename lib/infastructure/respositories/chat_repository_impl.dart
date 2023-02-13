import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_left_user_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GraphQlDatasource graphQlDatasource;
  ChatRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi(
      CreateGroupchatDto createGroupchatDto) async {
    try {
      Map<String, dynamic> variables = {
        "input": createGroupchatDto.toMap(),
      };
      if (createGroupchatDto.profileImage != null) {
        final byteData = createGroupchatDto.profileImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${createGroupchatDto.title}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'profileImage': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation CreateGroupchat(\$input: CreateGroupchatInput!, \$profileImage: Upload) {
          createGroupchat(createGroupchatInput: \$input, profileImage: \$profileImage) {
            _id
            title
            description
            profileImageLink
            users {
              _id
              admin
              userId
              usernameForChat
              groupchatTo
              createdAt
              updatedAt
            }
            leftUsers {
              _id
              userId
              createdAt
              updatedAt
              leftGroupchatTo
            }
            createdBy
            createdAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        print(response.exception);
        return Left(GeneralFailure());
      }
      return Right(GroupchatModel.fromJson(response.data!["createGroupchat"]));
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindGroupchat(\$input: FindOneGroupchatInput!) {
          findGroupchat(filter: \$input) {
            _id
            title
            description
            profileImageLink
            users {
              _id
              admin
              userId
              usernameForChat
              groupchatTo
              createdAt
              updatedAt
            }
            leftUsers {
              _id
              userId
              createdAt
              updatedAt
              leftGroupchatTo
            }
            createdBy
            createdAt
          }
        }
        """,
        variables: {
          "input": getOneGroupchatFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(GroupchatModel.fromJson(response.data!["findGroupchat"]));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi() async {
    try {
      final response = await graphQlDatasource.query("""
        query FindGroupchats {
          findGroupchats {
            _id
            profileImageLink
            title
            users {
              _id
              userId
              usernameForChat
            }
          }
        }
        """);

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      final List<GroupchatEntity> groupchats = [];
      for (final groupchat in response.data!["findGroupchats"]) {
        groupchats.add(GroupchatModel.fromJson(groupchat));
      }
      return Right(groupchats);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatEntity>> updateGroupchatViaApi() async {
    // TODO: implement updateGroupchatViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, GroupchatEntity>> addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation AddUserToGroupchat(\$input: CreateGroupchatUserInput!) {
          addUserToGroupchat(createGroupchatUserInput: \$input) {
            _id
            users {
              _id
              admin
              userId
              groupchatTo
              usernameForChat
              createdAt
              updatedAt
            }
            leftUsers {
              _id
              userId
              createdAt
              updatedAt
              leftGroupchatTo
            }
          }
        }
        """,
        variables: {
          "input": createGroupchatUserDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        GroupchatModel.fromJson(response.data!["addUserToGroupchat"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatEntity>> deleteUserFromGroupchatViaApi({
    required CreateGroupchatLeftUserDto createGroupchatLeftUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteUserFromGroupchat(\$input: CreateGroupchatLeftUserInput!) {
          deleteUserFromGroupchat(createGroupchatLeftUserInput: \$input) {
            _id
            users {
              _id
              admin
              userId
              groupchatTo
              usernameForChat
              createdAt
              updatedAt
            }
            leftUsers {
              _id
              userId
              createdAt
              updatedAt
              leftGroupchatTo
            }
          }
        }
        """,
        variables: {"input": createGroupchatLeftUserDto.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        GroupchatModel.fromJson(response.data!["deleteUserFromGroupchat"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroupchatViaApi() async {
    // TODO: implement deleteGroupchatViaApi
    throw UnimplementedError();
  }
}
