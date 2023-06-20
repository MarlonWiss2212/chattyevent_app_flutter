import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<NotificationAlert, List<ChatEntity>>> getChatsViaApi();
}
