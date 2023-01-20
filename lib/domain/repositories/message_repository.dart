import 'package:dartz/dartz.dart';
import 'package:graphql/client.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  });
  Future<Either<Failure, MessageEntity>> getMessageViaApi();
  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi({
    required GetMessagesFilter getMessagesFilter,
  });
  Either<Failure, Stream<QueryResult<Object?>>> getMessagesRealtimeViaApi();
}
