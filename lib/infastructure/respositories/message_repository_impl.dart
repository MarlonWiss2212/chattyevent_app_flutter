import 'package:graphql/client.dart';
import 'package:social_media_app_flutter/core/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
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
  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindMessages(\$input: FindMessagesInput!) {
          findMessages(filter: \$input) {
            _id
            message
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "input": getMessagesFilter.toMap(),
        },
      );

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

  @override
  Either<Failure, Stream<QueryResult<Object?>>> getMessagesRealtimeViaApi() {
    try {
      final subscription = graphQlDatasource.subscription(
        """
        subscription {
          messageAdded {
            _id
            message
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
      );

      return Right(subscription);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
