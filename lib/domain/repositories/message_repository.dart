import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  });
  Future<Either<Failure, MessageEntity>> getMessageViaApi();
  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi();
}
