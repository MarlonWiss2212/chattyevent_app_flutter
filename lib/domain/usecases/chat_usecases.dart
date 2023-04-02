import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';

class ChatUseCases {
  final ChatRepository chatRepository;
  ChatUseCases({required this.chatRepository});

  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi({
    LimitOffsetFilterOptional? messageFilterForEveryGroupchat,
  }) async {
    return await chatRepository.getGroupchatsViaApi(
      messageFilterForEveryGroupchat: messageFilterForEveryGroupchat,
    );
  }

  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    GetMessagesFilter? getMessagesFilter,
  }) async {
    return await chatRepository.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
      getMessagesFilter: getMessagesFilter,
    );
  }

  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi({
    required CreateGroupchatDto createGroupchatDto,
  }) async {
    return await chatRepository.createGroupchatViaApi(createGroupchatDto);
  }

  Future<Either<Failure, GroupchatUserEntity>> addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  }) async {
    return await chatRepository.addUserToGroupchatViaApi(
      createGroupchatUserDto: createGroupchatUserDto,
    );
  }

  Future<Either<Failure, GroupchatEntity>> updateGroupchatViaApi({
    required UpdateGroupchatDto updateGroupchatDto,
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    return await chatRepository.updateGroupchatViaApi(
      updateGroupchatDto: updateGroupchatDto,
      getOneGroupchatFilter: getOneGroupchatFilter,
    );
  }

  Future<Either<Failure, GroupchatUserEntity>> updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  }) async {
    return await chatRepository.updateGroupchatUserViaApi(
      updateGroupchatUserDto: updateGroupchatUserDto,
      getOneGroupchatUserFilter: getOneGroupchatUserFilter,
    );
  }

  Future<Either<Failure, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  }) async {
    return await chatRepository.deleteUserFromGroupchatViaApi(
      getOneGroupchatUserFilter: getOneGroupchatUserFilter,
    );
  }
}
