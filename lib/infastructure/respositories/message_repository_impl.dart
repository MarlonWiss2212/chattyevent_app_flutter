import 'dart:async';
import 'package:chattyevent_app_flutter/core/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/message/message_model.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/message/create_message_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/message_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';

class MessageRepositoryImpl implements MessageRepository {
  final GraphQlDatasource graphQlDatasource;
  MessageRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "input": createMessageDto.toMap(),
      };

      /// TODO: should accapt other files than jpg too
      /// TODO: limit size and scale down
      if (createMessageDto.file != null) {
        final MultipartFile file = MultipartFile.fromBytes(
          'photo',
          createMessageDto.file!.readAsBytesSync(),
          filename: '1.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'file': file});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation createMessage(\$input: CreateMessageInput!, \$file: Upload) {
          createMessage(createMessageInput: \$input, file: \$file) {
            _id
            message
            messageToReactTo
            fileLinks
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen Nachricht Fehler",
          response: response,
        ));
      }
      return Right(MessageModel.fromJson(response.data!["createMessage"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required FindMessagesFilter findMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindMessages(\$input: FindMessagesInput!, \$limitOffsetFilter: LimitOffsetInput!) {
          findMessages(filter: \$input, limitOffsetInput: \$limitOffsetFilter) {
            _id
            message
            messageToReactTo
            fileLinks
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "input": findMessagesFilter.toMap(),
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Nachrichten Fehler",
          response: response,
        ));
      }

      final List<MessageEntity> messages = [];
      for (final message in response.data!["findMessages"]) {
        messages.add(MessageModel.fromJson(message));
      }
      return Right(messages);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, Stream<Either<NotificationAlert, MessageEntity>>>
      getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  }) {
    try {
      final Stream<QueryResult<Object?>> subscription =
          graphQlDatasource.subscription(
        """
        subscription(\$addedMessageInput: AddedMessageInput!) {
          messageAdded(addedMessageInput: \$addedMessageInput) {
            _id
            message
            messageToReactTo
            groupchatTo
            fileLinks
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "addedMessageInput": addedMessageFilter.toMap(),
        },
      );

      Stream<Either<NotificationAlert, MessageEntity>>
          subscriptionToStream() async* {
        await for (var event in subscription) {
          if (event.hasException) {
            yield Left(FailureHelper.graphqlFailureToNotificationAlert(
              title: "Nachrichten Fehler",
              response: event,
            ));
          }
          if (event.data != null) {
            final message = MessageModel.fromJson(event.data!['messageAdded']);
            yield Right(message);
          }
        }
      }

      return Right(subscriptionToStream());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
