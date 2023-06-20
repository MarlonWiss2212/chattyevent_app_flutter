import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class ChatUseCase {
  final ChatRepository chatRepository;
  ChatUseCase({required this.chatRepository});

  Future<Either<NotificationAlert, List<ChatEntity>>> getChatsViaApi() async {
    return await chatRepository.getChatsViaApi();
  }
}
