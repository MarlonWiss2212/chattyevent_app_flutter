import 'dart:async';
import 'package:chattyevent_app_flutter/infrastructure/dto/message/create_message_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/message/find_one_message_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/message/updated_message_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';

/// Repository for handling message-related functionality.
abstract class MessageRepository {
  /// Creates a message via API.
  /// Returns a [NotificationAlert] in case of an error or a [MessageEntity] when successful.
  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  });

  /// Retrieves messages via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [MessageEntity] when successful.
  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required FindMessagesFilter findMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Retrieves messages in real-time via API.
  /// Returns a [NotificationAlert] in case of an error or a stream of [MessageEntity] when successful.
  Future<
          Either<NotificationAlert,
              Stream<Either<NotificationAlert, MessageEntity>>>>
      getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  });

  /// Retrieves updated messages in real-time via API.
  /// Returns a [NotificationAlert] in case of an error or a stream of [MessageEntity] when successful.
  Future<
          Either<NotificationAlert,
              Stream<Either<NotificationAlert, MessageEntity>>>>
      getUpdatedMessagesRealtimeViaApi({
    required UpdatedMessageFilter updatedMessageFilter,
  });

  /// Deletes a message via API.
  /// Returns a [NotificationAlert] in case of an error or a [MessageEntity] when successful.
  Future<Either<NotificationAlert, MessageEntity>> deleteMessageViaApi({
    required FindOneMessage filter,
  });
}
