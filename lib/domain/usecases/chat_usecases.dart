import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';

class ChatUseCases {
  final ChatRepository chatRepository;
  ChatUseCases({required this.chatRepository});

  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi() async {
    return await chatRepository.getGroupchatsViaApi();
  }
}
