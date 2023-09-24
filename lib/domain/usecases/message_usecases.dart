import 'dart:async';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/message/create_message_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';

class MessageUseCases {
  final MessageRepository messageRepository;
  MessageUseCases({required this.messageRepository});

  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    return messageRepository.createMessageViaApi(
      createMessageDto: createMessageDto,
    );
  }

  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required FindMessagesFilter findMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return messageRepository.getMessagesViaApi(
      findMessagesFilter: findMessagesFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<
          Either<NotificationAlert,
              Stream<Either<NotificationAlert, MessageEntity>>>>
      getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  }) {
    return messageRepository.getMessagesRealtimeViaApi(
      addedMessageFilter: addedMessageFilter,
    );
  }
}
