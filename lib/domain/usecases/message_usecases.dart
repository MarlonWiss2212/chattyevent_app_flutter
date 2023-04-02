import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';

class MessageUseCases {
  final MessageRepository messageRepository;
  MessageUseCases({required this.messageRepository});

  Future<Either<Failure, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    return await messageRepository.createMessageViaApi(
      createMessageDto: createMessageDto,
    );
  }

  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  }) async {
    return await messageRepository.getMessagesViaApi(
      getMessagesFilter: getMessagesFilter,
    );
  }

  Stream<Either<Failure, MessageEntity>> getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  }) {
    return messageRepository.getMessagesRealtimeViaApi(
      addedMessageFilter: addedMessageFilter,
    );
  }
}
