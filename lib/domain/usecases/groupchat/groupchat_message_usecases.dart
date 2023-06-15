import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_message/create_groupchat_message_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_message/added_groupchat_message_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_message/find_groupchat_messages_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/domain/repositories/groupchat/groupchat_message_repository.dart';

class GroupchatMessageUseCases {
  final GroupchatMessageRepository groupchatMessageRepository;
  GroupchatMessageUseCases({required this.groupchatMessageRepository});

  Future<Either<NotificationAlert, GroupchatMessageEntity>>
      createGroupchatMessageViaApi({
    required CreateGroupchatMessageDto createGroupchatMessageDto,
  }) async {
    return groupchatMessageRepository.createGroupchatMessageViaApi(
      createGroupchatMessageDto: createGroupchatMessageDto,
    );
  }

  Future<Either<NotificationAlert, List<GroupchatMessageEntity>>>
      getGroupchatMessagesViaApi({
    required FindGroupchatMessagesFilter findGroupchatMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return groupchatMessageRepository.getGroupchatMessagesViaApi(
      findGroupchatMessagesFilter: findGroupchatMessagesFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Either<NotificationAlert,
          Stream<Either<NotificationAlert, GroupchatMessageEntity>>>
      getGroupchatMessagesRealtimeViaApi({
    required AddedGroupchatMessageFilter addedGroupchatMessageFilter,
  }) {
    return groupchatMessageRepository.getGroupchatMessagesRealtimeViaApi(
      addedGroupchatMessageFilter: addedGroupchatMessageFilter,
    );
  }
}
