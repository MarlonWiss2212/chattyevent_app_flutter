import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/message/message_model.dart';

class MessageRepositoryImpl implements MessageRepository {
  final GraphQlDatasource graphQlDatasource;
  MessageRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation createMessage(\$input: CreateMessageInput!) {
          createMessage(createMessageInput: \$input) {
            _id
            message
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
        variables: {"input": createMessageDto.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(MessageModel.fromJson(response.data!["createMessage"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> getMessageViaApi() async {
    // TODO: implement getMessageViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi() async {
    try {
      final response = await graphQlDatasource.query("""
        query FindMessages {
          findMessages {
            _id
            message
            groupchatTo
            createdBy
            createdAt
          }
        }
      """);

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      final List<MessageEntity> messages = [];
      for (final message in response.data!["findMessages"]) {
        messages.add(MessageModel.fromJson(message));
      }
      return Right(messages);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
