import 'dart:async';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/message/create_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/core/utils/failure_helper.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/message/message_model.dart';

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
      if (createMessageDto.file != null) {
        final byteData = createMessageDto.file!.readAsBytesSync();

        /// TODO: should accapt other files than jpg too
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '1.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'file': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation createMessage(\$input: CreateMessageInput!, \$file: Upload) {
          createMessage(createMessageInput: \$input, file: \$file) {
            _id
            message
            messageToReactTo
            fileLink
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
          exception: response.exception!,
        ));
      }
      return Right(MessageModel.fromJson(response.data!["createMessage"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, MessageEntity>> getMessageViaApi() async {
    // TODO: implement getMessageViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindMessages(\$input: FindMessagesInput!) {
          findMessages(filter: \$input) {
            _id
            message
            messageToReactTo
            groupchatTo
            fileLink
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
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Nachrichten Fehler",
          exception: response.exception!,
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
  Stream<Either<NotificationAlert, MessageEntity>> getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  }) async* {
    try {
      final subscription = graphQlDatasource.subscription(
        """
        subscription(\$addedMessageInput: AddedMessageInput!) {
          messageAdded(addedMessageInput: \$addedMessageInput) {
            _id
            message
            messageToReactTo
            groupchatTo
            fileLink
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "addedMessageInput": addedMessageFilter.toMap(),
        },
      );

      await for (var event in subscription) {
        if (event.hasException) {
          yield Left(FailureHelper.graphqlFailureToNotificationAlert(
            title: "Nachricht Fehler",
            exception: event.exception!,
          ));
        }
        if (event.data != null) {
          final message = MessageModel.fromJson(event.data!['messageAdded']);
          yield Right(message);
        }
      }
    } catch (e) {
      yield Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
