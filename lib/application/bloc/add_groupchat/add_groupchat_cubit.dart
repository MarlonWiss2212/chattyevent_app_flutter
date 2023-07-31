import 'dart:io';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/create_groupchat_permissions_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';

part 'add_groupchat_state.dart';

class AddGroupchatCubit extends Cubit<AddGroupchatState> {
  final ChatCubit chatCubit;
  final GroupchatUseCases groupchatUseCases;
  final NotificationCubit notificationCubit;

  AddGroupchatCubit({
    required this.chatCubit,
    required this.notificationCubit,
    required this.groupchatUseCases,
  }) : super(AddGroupchatState(
          subtitle: "",
          groupchatUsers: [],
          permissions: CreateGroupchatPermissionsDto(
            addUsers: GroupchatPermissionEnum.adminsonly,
            changeDescription: GroupchatPermissionEnum.everyone,
            changeProfileImage: GroupchatPermissionEnum.everyone,
            changeTitle: GroupchatPermissionEnum.everyone,
            createEventForGroupchat: GroupchatPermissionEnum.adminsonly,
          ),
        ));

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
        permissions: state.permissions,
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
          chat: ChatEntity(groupchat: groupchat),
        );
        emit(AddGroupchatState(
          subtitle: "",
          groupchatUsers: [],
          addedChat: groupchat,
          permissions: CreateGroupchatPermissionsDto(),
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
    CreateGroupchatPermissionsDto? permissions,
    List<CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity>?
        groupchatUsers,
    AddGroupchatStateStatus? status,
    GroupchatEntity? addedChat,
    String? subtitle,
  }) {
    emit(AddGroupchatState(
      subtitle: subtitle ?? state.subtitle,
      title: title ?? state.title,
      profileImage: profileImage ?? state.profileImage,
      permissions: permissions ?? state.permissions,
      description: description ?? state.description,
      groupchatUsers: groupchatUsers ?? state.groupchatUsers,
      status: status ?? AddGroupchatStateStatus.initial,
      addedChat: addedChat ?? state.addedChat,
    ));
  }
}
