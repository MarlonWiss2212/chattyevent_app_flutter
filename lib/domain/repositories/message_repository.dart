import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/message/create_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  });
  Future<Either<Failure, MessageEntity>> getMessageViaApi();
  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  });
  Stream<Either<Failure, MessageEntity>> getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  });
}
