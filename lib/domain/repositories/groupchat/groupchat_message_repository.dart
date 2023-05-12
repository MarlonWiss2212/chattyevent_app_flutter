import 'dart:async';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_message/create_groupchat_message_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_message/added_groupchat_message_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_message/find_groupchat_messages_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';

abstract class GroupchatMessageRepository {
  Future<Either<NotificationAlert, GroupchatMessageEntity>>
      createGroupchatMessageViaApi({
    required CreateGroupchatMessageDto createGroupchatMessageDto,
  });
  Future<Either<NotificationAlert, List<GroupchatMessageEntity>>>
      getGroupchatMessagesViaApi({
    required FindGroupchatMessagesFilter findGroupchatMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Either<NotificationAlert,
          Stream<Either<NotificationAlert, GroupchatMessageEntity>>>
      getGroupchatMessagesRealtimeViaApi({
    required AddedGroupchatMessageFilter addedGroupchatMessageFilter,
  });
}
