import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';

class MessageUseCases {
  final MessageRepository messageRepository;
  MessageUseCases({required this.messageRepository});

  Future<Either<Failure, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    return await messageRepository.createMessageViaApi(
        createMessageDto: createMessageDto);
  }

  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  }) async {
    return await messageRepository.getMessagesViaApi(
      getMessagesFilter: getMessagesFilter,
    );
  }
}
