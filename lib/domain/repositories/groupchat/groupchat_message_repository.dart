import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_message/create_groupchat_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';

abstract class GroupchatMessageRepository {
  Future<Either<NotificationAlert, MessageEntity>>
      createGroupchatMessageViaApi({
    required CreateGroupchatMessageDto createGroupchatMessageDto,
  });
  Future<Either<NotificationAlert, List<MessageEntity>>>
      getGroupchatMessagesViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Stream<Either<NotificationAlert, MessageEntity>>
      getGroupchatMessagesRealtimeViaApi({
    required AddedGroupchatMessageFilter addedGroupchatMessageFilter,
  });
}
