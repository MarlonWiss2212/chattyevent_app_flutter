import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user/create_user_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';

part 'add_current_user_state.dart';

class AddCurrentUserCubit extends Cubit<AddCurrentUserState> {
  final UserUseCases userUseCases;
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  AddCurrentUserCubit({
    required this.userUseCases,
    required this.notificationCubit,
    required this.authCubit,
  }) : super(AddCurrentUserState());

  Future createCurrentUser() async {
    emitState(status: AddCurrentUserStateStatus.loading);

    if (state.firstname == null ||
        state.lastname == null ||
        state.username == null ||
        state.birthdate == null) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Ausfüll Fehler",
          message: "Fülle bitte erst alle Felder aus",
        ),
      );
    }

    final Either<NotificationAlert, UserEntity> userOrFailure =
        await userUseCases.createUserViaApi(
      createUserDto: CreateUserDto(
        firstname: state.firstname!,
        lastname: state.lastname!,
        username: state.username!,
        birthdate: state.birthdate!,
        profileImage: state.profileImage,
      ),
    );

    userOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AddCurrentUserStateStatus.initial);
      },
      (user) {
        authCubit.emitState(currentUser: user, resetUserException: true);
        emit(AddCurrentUserState(
          addedUser: user,
          status: AddCurrentUserStateStatus.created,
        ));
      },
    );
  }

  void emitState({
    File? profileImage,
    String? firstname,
    String? lastname,
    String? username,
    DateTime? birthdate,
    AddCurrentUserStateStatus? status,
  }) {
    emit(AddCurrentUserState(
      profileImage: profileImage ?? state.profileImage,
      firstname: firstname ?? state.firstname,
      lastname: lastname ?? state.lastname,
      username: username ?? state.username,
      birthdate: birthdate ?? state.birthdate,
      status: status ?? AddCurrentUserStateStatus.initial,
    ));
  }
}
