import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_left_user/create_groupchat_left_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/groupchat_user/find_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:social_media_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/groupchat/groupchat_repository.dart';

class GroupchatUseCases {
  final GroupchatRepository groupchatRepository;
  GroupchatUseCases({required this.groupchatRepository});

  Future<Either<NotificationAlert, List<GroupchatEntity>>>
      getGroupchatsViaApi() async {
    return await groupchatRepository.getGroupchatsViaApi();
  }

  Future<Either<NotificationAlert, GroupchatEntity>> getGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  }) async {
    return await groupchatRepository.getGroupchatViaApi(
      findOneGroupchatFilter: findOneGroupchatFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatAndGroupchatUsersResponse>>
      getGroupchatDataViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
    required LimitOffsetFilter limitOffsetFilterMessages,
  }) async {
    return await groupchatRepository.getGroupchatDataViaApi(
      findOneGroupchatFilter: findOneGroupchatFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatEntity>> createGroupchatViaApi({
    required CreateGroupchatDto createGroupchatDto,
  }) async {
    return await groupchatRepository.createGroupchatViaApi(createGroupchatDto);
  }

  Future<Either<NotificationAlert, GroupchatUserEntity>>
      addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  }) async {
    return await groupchatRepository.addUserToGroupchatViaApi(
      createGroupchatUserDto: createGroupchatUserDto,
    );
  }

  Future<Either<NotificationAlert, GroupchatEntity>> updateGroupchatViaApi({
    required UpdateGroupchatDto updateGroupchatDto,
    required FindOneGroupchatFilter findOneGroupchatFilter,
  }) async {
    return await groupchatRepository.updateGroupchatViaApi(
      updateGroupchatDto: updateGroupchatDto,
      findOneGroupchatFilter: findOneGroupchatFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatUserEntity>>
      updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required FindOneGroupchatUserFilter findOneGroupchatUserFilter,
  }) async {
    return await groupchatRepository.updateGroupchatUserViaApi(
      updateGroupchatUserDto: updateGroupchatUserDto,
      findOneGroupchatUserFilter: findOneGroupchatUserFilter,
    );
  }

  Future<Either<NotificationAlert, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required CreateGroupchatLeftUserDto createGroupchatLeftUserDto,
  }) async {
    return await groupchatRepository.deleteUserFromGroupchatViaApi(
      createGroupchatLeftUserDto: createGroupchatLeftUserDto,
    );
  }

  Future<Either<NotificationAlert, GroupchatUsersAndLeftUsersResponse>>
      getGroupchatUsersAndLeftUsers({
    required FindOneGroupchatToFilter findOneGroupchatToFilter,
  }) async {
    return await groupchatRepository.getGroupchatUsersAndLeftUsers(
      findOneGroupchatToFilter: findOneGroupchatToFilter,
    );
  }
}
