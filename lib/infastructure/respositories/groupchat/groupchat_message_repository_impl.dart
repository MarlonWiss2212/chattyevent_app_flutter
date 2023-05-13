import 'dart:async';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_message_model.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_message/create_groupchat_message_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_message/added_groupchat_message_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_message/find_groupchat_messages_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/groupchat/groupchat_message_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';

class GroupchatMessageRepositoryImpl implements GroupchatMessageRepository {
  final GraphQlDatasource graphQlDatasource;

  GroupchatMessageRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, GroupchatMessageEntity>>
      createGroupchatMessageViaApi({
    required CreateGroupchatMessageDto createGroupchatMessageDto,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "input": createGroupchatMessageDto.toMap(),
      };

      /// TODO: should accapt other files than jpg too
      /// TODO: limit size and scale down
      if (createGroupchatMessageDto.files != null) {
        final List<MultipartFile> files =
            createGroupchatMessageDto.files!.asMap().entries.map((entry) {
          return MultipartFile.fromBytes(
            'photo',
            entry.value.readAsBytesSync(),
            filename: '${entry.key}.jpg',
            contentType: MediaType("image", "jpg"),
          );
        }).toList();
        variables.addAll({'files': files});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation createGroupchatMessage(\$input: CreateGroupchatMessageInput!, \$files: [Upload!]) {
          createGroupchatMessage(createGroupchatMessageInput: \$input, files: \$files) {
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
      return Right(GroupchatMessageModel.fromJson(
          response.data!["createGroupchatMessage"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<GroupchatMessageEntity>>>
      getGroupchatMessagesViaApi({
    required FindGroupchatMessagesFilter findGroupchatMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindGroupchatMessages(\$input: FindGroupchatMessagesInput!, \$limitOffsetFilter: LimitOffsetInput!) {
          findGroupchatMessages(filter: \$input, limitOffsetInput: \$limitOffsetFilter) {
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
          "input": findGroupchatMessagesFilter.toMap(),
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Nachrichten Fehler",
          response: response,
        ));
      }

      final List<GroupchatMessageEntity> messages = [];
      for (final message in response.data!["findGroupchatMessages"]) {
        messages.add(GroupchatMessageModel.fromJson(message));
      }
      return Right(messages);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert,
          Stream<Either<NotificationAlert, GroupchatMessageEntity>>>
      getGroupchatMessagesRealtimeViaApi({
    required AddedGroupchatMessageFilter addedGroupchatMessageFilter,
  }) {
    try {
      final Stream<QueryResult<Object?>> subscription =
          graphQlDatasource.subscription(
        """
        subscription(\$addedGroupchatMessageInput: AddedGroupchatMessageInput!) {
          groupchatMessageAdded(addedGroupchatMessageInput: \$addedGroupchatMessageInput) {
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
          "addedGroupchatMessageInput": addedGroupchatMessageFilter.toMap(),
        },
      );

      Stream<Either<NotificationAlert, GroupchatMessageEntity>>
          subscriptionToStream() async* {
        await for (var event in subscription) {
          if (event.hasException) {
            yield Left(FailureHelper.graphqlFailureToNotificationAlert(
              title: "Nachrichten Fehler",
              response: event,
            ));
          }
          if (event.data != null) {
            final message = GroupchatMessageModel.fromJson(
              event.data!['groupchatMessageAdded'],
            );
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
