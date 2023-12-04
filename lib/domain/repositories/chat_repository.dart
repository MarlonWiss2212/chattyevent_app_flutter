import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:dartz/dartz.dart';

/// Repository for handling chat-related functionality.
abstract class ChatRepository {
  /// Retrieves chats via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [ChatEntity] when successful.
  Future<Either<NotificationAlert, List<ChatEntity>>> getChatsViaApi();
}
