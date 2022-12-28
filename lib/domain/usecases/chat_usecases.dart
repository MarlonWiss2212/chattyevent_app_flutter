import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';

class ChatUseCases {
  final ChatRepository chatRepository;
  ChatUseCases({required this.chatRepository});

  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi() async {
    return await chatRepository.getGroupchatsViaApi();
  }

  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    return await chatRepository.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );
  }

  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi(
      {required CreateGroupchatDto createGroupchatDto}) async {
    return await chatRepository.createGroupchatViaApi(createGroupchatDto);
  }

  Future<Either<Failure, GroupchatEntity>> addUserToGroupchatViaApi({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    return await chatRepository.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );
  }

  Future<Either<Failure, GroupchatEntity>> deleteUserFromGroupchatViaApi({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    return await chatRepository.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );
  }
}
