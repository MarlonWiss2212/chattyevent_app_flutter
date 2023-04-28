import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/message/create_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';

class MessageUseCases {
  final MessageRepository messageRepository;
  MessageUseCases({required this.messageRepository});

  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    return await messageRepository.createMessageViaApi(
      createMessageDto: createMessageDto,
    );
  }

  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await messageRepository.getMessagesViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Stream<Either<NotificationAlert, MessageEntity>> getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  }) {
    return messageRepository.getMessagesRealtimeViaApi(
      addedMessageFilter: addedMessageFilter,
    );
  }
}
