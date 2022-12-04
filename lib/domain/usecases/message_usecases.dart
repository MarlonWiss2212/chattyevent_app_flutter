import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';

class MessageUseCases {
  final MessageRepository messageRepository;
  MessageUseCases({required this.messageRepository});

  Future<Either<Failure, List<MessageEntity>>> getMessagesViaApi() async {
    return await messageRepository.getMessagesViaApi();
  }
}
