import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';

abstract class ChatRepository {
  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi(
    CreateGroupchatDto createGroupchatDto,
  );
  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    GetMessagesFilter? getMessagesFilter,
  });
  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi({
    LimitOffsetFilterOptional? limitOffsetFilter,
  });
  Future<Either<Failure, GroupchatEntity>> updateGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    required UpdateGroupchatDto updateGroupchatDto,
  });
  Future<Either<Failure, GroupchatUserEntity>> addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  });
  Future<Either<Failure, GroupchatUserEntity>> updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  });
  Future<Either<Failure, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  });
}
