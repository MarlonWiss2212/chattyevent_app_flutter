import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/groupchat/groupchat_usecases.dart';

part 'add_groupchat_state.dart';

class AddGroupchatCubit extends Cubit<AddGroupchatState> {
  final ChatCubit chatCubit;
  final GroupchatUseCases groupchatUseCases;
  final NotificationCubit notificationCubit;

  AddGroupchatCubit({
    required this.chatCubit,
    required this.notificationCubit,
    required this.groupchatUseCases,
  }) : super(AddGroupchatState(groupchatUsers: []));

  Future createGroupchatViaApi() async {
    if (state.title == null) {
      notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
        title: "Fehler",
        message: "Bitte fülle alle verpflichtenen Felder aus",
      ));
      return;
    }

    emitState(status: AddGroupchatStateStatus.loading);

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.createGroupchatViaApi(
      createGroupchatDto: CreateGroupchatDto(
        title: state.title!,
        profileImage: state.profileImage,
        description: state.description,
        groupchatUsers: state.groupchatUsers,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        emitState(status: AddGroupchatStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (groupchat) {
        chatCubit.replaceOrAdd(
          chatState: CurrentChatState(
            currentUserIndex: -1,
            currentUserLeftChat: false,
            loadingPrivateEvents: false,
            messages: groupchat.latestMessage != null
                ? [groupchat.latestMessage!]
                : [],
            futureConnectedPrivateEvents: [],
            loadingMessages: false,
            currentChat: groupchat,
            loadingChat: false,
            users: [],
            leftUsers: [],
          ),
        );
        emit(AddGroupchatState(
          groupchatUsers: [],
          addedChat: groupchat,
          status: AddGroupchatStateStatus.success,
        ));
      },
    );
  }

  void addGroupchatUserToList({
    required CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity
        groupchatUser,
  }) {
    emitState(
      groupchatUsers: List.from(state.groupchatUsers)..add(groupchatUser),
    );
  }

  void removeGroupchatUserUserFromList({
    required String userId,
  }) {
    emitState(
      groupchatUsers: state.groupchatUsers
          .where((element) => element.user.id != userId)
          .toList(),
    );
  }

  void emitState({
    String? title,
    File? profileImage,
    String? description,
    List<CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity>?
        groupchatUsers,
    AddGroupchatStateStatus? status,
    GroupchatEntity? addedChat,
  }) {
    emit(AddGroupchatState(
      title: title ?? state.title,
      profileImage: profileImage ?? state.profileImage,
      description: description ?? state.description,
      groupchatUsers: groupchatUsers ?? state.groupchatUsers,
      status: status ?? AddGroupchatStateStatus.initial,
      addedChat: addedChat ?? state.addedChat,
    ));
  }
}
