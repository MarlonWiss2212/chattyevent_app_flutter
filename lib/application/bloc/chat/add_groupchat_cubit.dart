import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'add_groupchat_state.dart';

class AddGroupchatCubit extends Cubit<AddGroupchatState> {
  final ChatCubit chatCubit;
  final ChatUseCases chatUseCases;
  AddGroupchatCubit({
    required this.chatCubit,
    required this.chatUseCases,
  }) : super(AddGroupchatState(
          createGroupchatDto: CreateGroupchatDto(title: ""),
        ));

  Future createGroupchatViaApi() async {
    emit(AddGroupchatState(
      createGroupchatDto: state.createGroupchatDto,
      status: AddChatStateStatus.loading,
    ));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.createGroupchatViaApi(
      createGroupchatDto: state.createGroupchatDto,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(
          AddGroupchatState(
            createGroupchatDto: state.createGroupchatDto,
            status: AddChatStateStatus.error,
            error: ErrorWithTitleAndMessage(
              title: "Fehler",
              message: mapFailureToMessage(error),
            ),
          ),
        );
      },
      (groupchat) {
        chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(AddGroupchatState(
          addedChat: groupchat,
          createGroupchatDto: state.createGroupchatDto,
          status: AddChatStateStatus.success,
        ));
      },
    );
  }

  void setCreateGroupchatDto({
    String? title,
    File? profileImage,
    String? description,
    List<CreateGroupchatUserFromCreateGroupchatDto>? groupchatUsers,
  }) {
    emit(AddGroupchatState(
      createGroupchatDto: CreateGroupchatDto(
        title: title ?? state.createGroupchatDto.title,
        profileImage: profileImage ?? state.createGroupchatDto.profileImage,
        description: description ?? state.createGroupchatDto.description,
        groupchatUsers:
            groupchatUsers ?? state.createGroupchatDto.groupchatUsers,
      ),
    ));
  }
}
