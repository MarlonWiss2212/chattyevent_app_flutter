import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GraphQlDatasource graphQlDatasource;
  ChatRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi(
      CreateGroupchatDto createGroupchatDto) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation CreateGroupchat(\$input: CreateGroupchatInput!) {
          createGroupchat(createGroupchatInput: \$input) {
            _id
            title
          }
        }
      """,
        variables: {"input": createGroupchatDto.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(GroupchatModel.fromJson(response.data!["createGroupchat"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi() async {
    // TODO: implement getGroupchatViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi() async {
    try {
      final response = await graphQlDatasource.query("""
        query FindGroupchats {
          findGroupchats {
            _id
            title
            users {
              userId
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
  Future<Either<Failure, void>> deleteGroupchatViaApi() async {
    // TODO: implement deleteGroupchatViaApi
    throw UnimplementedError();
  }
}
