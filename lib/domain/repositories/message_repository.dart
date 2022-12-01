import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageEntity>> createMessageViaApi();
  Future<Either<Failure, MessageEntity>> getMessageViaApi();
  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi();
}
