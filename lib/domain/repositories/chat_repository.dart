import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class ChatRepository {
  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi(
    CreateGroupchatDto createGroupchatDto,
  );
  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi();
  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi();
  Future<Either<Failure, GroupchatEntity>> updateGroupchatViaApi();
  Future<Either<Failure, void>> deleteGroupchatViaApi();
}
