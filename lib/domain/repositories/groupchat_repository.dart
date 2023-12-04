import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat_add_user.response.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/groupchat_left_user/create_groupchat_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/groupchat/groupchat_user/find_one_groupchat_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/groupchat/find_one_groupchat_filter.dart';

/// Repository for handling group chat-related functionality.
abstract class GroupchatRepository {
  /// Creates a group chat via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatEntity] when successful.
  Future<Either<NotificationAlert, GroupchatEntity>> createGroupchatViaApi(
    CreateGroupchatDto createGroupchatDto,
  );

  /// Retrieves a group chat via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatEntity] when successful.
  Future<Either<NotificationAlert, GroupchatEntity>> getGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  });

  /// Retrieves group chat data via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatAndGroupchatUsersResponse] when successful.
  Future<Either<NotificationAlert, GroupchatAndGroupchatUsersResponse>>
      getGroupchatDataViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  });

  /// Retrieves group chats via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [GroupchatEntity] when successful.
  Future<Either<NotificationAlert, List<GroupchatEntity>>>
      getGroupchatsViaApi();

  /// Updates a group chat via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatEntity] when successful.
  Future<Either<NotificationAlert, GroupchatEntity>> updateGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
    required UpdateGroupchatDto updateGroupchatDto,
  });

  /// Adds a user to a group chat via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatAddUserResponse] when successful.
  Future<Either<NotificationAlert, GroupchatAddUserResponse>>
      addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  });

  /// Updates a group chat user via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatUserEntity] when successful.
  Future<Either<NotificationAlert, GroupchatUserEntity>>
      updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required FindOneGroupchatUserFilter findOneGroupchatUserFilter,
  });

  /// Deletes a user from a group chat via API.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatLeftUserEntity] when successful.
  Future<Either<NotificationAlert, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required CreateGroupchatLeftUserDto createGroupchatLeftUserDto,
  });

  /// Retrieves group chat users and left users.
  /// Returns a [NotificationAlert] in case of an error or a [GroupchatUsersAndLeftUsersResponse] when successful.
  Future<Either<NotificationAlert, GroupchatUsersAndLeftUsersResponse>>
      getGroupchatUsersAndLeftUsers({
    required FindOneGroupchatToFilter findOneGroupchatToFilter,
  });
}
