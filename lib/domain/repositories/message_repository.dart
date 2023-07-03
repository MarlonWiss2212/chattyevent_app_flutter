import 'dart:async';
import 'package:chattyevent_app_flutter/infastructure/dto/message/create_message_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';

abstract class MessageRepository {
  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  });
  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required FindMessagesFilter findMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Either<NotificationAlert, Stream<Either<NotificationAlert, MessageEntity>>>
      getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  });
}
