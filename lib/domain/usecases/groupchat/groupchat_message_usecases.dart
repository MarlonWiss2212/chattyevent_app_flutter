import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_message/create_groupchat_message_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_groupchat_message_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/groupchat/groupchat_message_repository.dart';

class GroupchatMessageUseCases {
  final GroupchatMessageRepository groupchatMessageRepository;
  GroupchatMessageUseCases({required this.groupchatMessageRepository});

  Future<Either<NotificationAlert, MessageEntity>>
      createGroupchatMessageViaApi({
    required CreateGroupchatMessageDto createGroupchatMessageDto,
  }) async {
    return await groupchatMessageRepository.createGroupchatMessageViaApi(
      createGroupchatMessageDto: createGroupchatMessageDto,
    );
  }

  Future<Either<NotificationAlert, List<MessageEntity>>>
      getGroupchatMessagesViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await groupchatMessageRepository.getGroupchatMessagesViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Stream<Either<NotificationAlert, MessageEntity>>
      getGroupchatMessagesRealtimeViaApi({
    required AddedGroupchatMessageFilter addedGroupchatMessageFilter,
  }) {
    return groupchatMessageRepository.getGroupchatMessagesRealtimeViaApi(
      addedGroupchatMessageFilter: addedGroupchatMessageFilter,
    );
  }
}
