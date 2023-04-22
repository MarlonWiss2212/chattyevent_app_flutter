import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:social_media_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';

class ChatUseCases {
  final ChatRepository chatRepository;
  ChatUseCases({required this.chatRepository});

  Future<Either<NotificationAlert, List<GroupchatEntity>>>
      getGroupchatsViaApi() async {
    return await chatRepository.getGroupchatsViaApi();
  }

  Future<Either<NotificationAlert, GroupchatEntity>> getGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    return await chatRepository.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatAndGroupchatUsersResponse>>
      getGroupchatDataViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    required LimitOffsetFilter limitOffsetFilterMessages,
  }) async {
    return await chatRepository.getGroupchatDataViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatEntity>> createGroupchatViaApi({
    required CreateGroupchatDto createGroupchatDto,
  }) async {
    return await chatRepository.createGroupchatViaApi(createGroupchatDto);
  }

  Future<Either<NotificationAlert, GroupchatUserEntity>>
      addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  }) async {
    return await chatRepository.addUserToGroupchatViaApi(
      createGroupchatUserDto: createGroupchatUserDto,
    );
  }

  Future<Either<NotificationAlert, GroupchatEntity>> updateGroupchatViaApi({
    required UpdateGroupchatDto updateGroupchatDto,
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    return await chatRepository.updateGroupchatViaApi(
      updateGroupchatDto: updateGroupchatDto,
      getOneGroupchatFilter: getOneGroupchatFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatUserEntity>>
      updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  }) async {
    return await chatRepository.updateGroupchatUserViaApi(
      updateGroupchatUserDto: updateGroupchatUserDto,
      getOneGroupchatUserFilter: getOneGroupchatUserFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  }) async {
    return await chatRepository.deleteUserFromGroupchatViaApi(
      getOneGroupchatUserFilter: getOneGroupchatUserFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatUsersAndLeftUsersResponse>>
      getGroupchatUsersAndLeftUsers({
    required String groupchatId,
  }) async {
    return await chatRepository.getGroupchatUsersAndLeftUsers(
      groupchatId: groupchatId,
    );
  }
}
