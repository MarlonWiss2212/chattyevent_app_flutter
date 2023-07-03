import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_left_user/create_groupchat_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/groupchat_user/find_one_groupchat_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';

abstract class GroupchatRepository {
  Future<Either<NotificationAlert, GroupchatEntity>> createGroupchatViaApi(
    CreateGroupchatDto createGroupchatDto,
  );
  Future<Either<NotificationAlert, GroupchatEntity>> getGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  });
  Future<Either<NotificationAlert, GroupchatAndGroupchatUsersResponse>>
      getGroupchatDataViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  });
  Future<Either<NotificationAlert, List<GroupchatEntity>>>
      getGroupchatsViaApi();
  Future<Either<NotificationAlert, GroupchatEntity>> updateGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
    required UpdateGroupchatDto updateGroupchatDto,
  });
  Future<Either<NotificationAlert, GroupchatUserEntity>>
      addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  });
  Future<Either<NotificationAlert, GroupchatUserEntity>>
      updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required FindOneGroupchatUserFilter findOneGroupchatUserFilter,
  });
  Future<Either<NotificationAlert, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required CreateGroupchatLeftUserDto createGroupchatLeftUserDto,
  });
  Future<Either<NotificationAlert, GroupchatUsersAndLeftUsersResponse>>
      getGroupchatUsersAndLeftUsers({
    required FindOneGroupchatToFilter findOneGroupchatToFilter,
  });
}
