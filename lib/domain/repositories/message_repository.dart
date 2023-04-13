import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/message/create_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';

abstract class MessageRepository {
  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  });
  Future<Either<NotificationAlert, MessageEntity>> getMessageViaApi();
  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  });
  Stream<Either<NotificationAlert, MessageEntity>> getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  });
}
