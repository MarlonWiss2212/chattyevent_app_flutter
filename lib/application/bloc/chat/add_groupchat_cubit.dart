import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'add_groupchat_state.dart';

class AddGroupchatCubit extends Cubit<AddGroupchatState> {
  final ChatCubit chatCubit;
  final ChatUseCases chatUseCases;
  AddGroupchatCubit({
    required this.chatCubit,
    required this.chatUseCases,
  }) : super(AddGroupchatState());

  Future createGroupchatViaApi() async {
    emitState(status: AddGroupchatStateStatus.loading);

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.createGroupchatViaApi(
      createGroupchatDto: CreateGroupchatDto(
        title: state.title ?? "",
        profileImage: state.profileImage,
        description: state.description,
        groupchatUsers: state.groupchatUsers,
      ),
    );

    groupchatOrFailure.fold(
      (error) {
        emitState(
          status: AddGroupchatStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (groupchat) {
        chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(AddGroupchatState(
          addedChat: groupchat,
          status: AddGroupchatStateStatus.success,
        ));
      },
    );
  }

  void emitState({
    String? title,
    File? profileImage,
    String? description,
    List<CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity>?
        groupchatUsers,
    AddGroupchatStateStatus? status,
    ErrorWithTitleAndMessage? error,
    GroupchatEntity? addedChat,
  }) {
    emit(AddGroupchatState(
      title: title ?? state.title,
      profileImage: profileImage ?? state.profileImage,
      description: description ?? state.description,
      groupchatUsers: groupchatUsers ?? state.groupchatUsers,
      status: status ?? AddGroupchatStateStatus.initial,
      error: error ?? state.error,
      addedChat: addedChat ?? state.addedChat,
    ));
  }
}