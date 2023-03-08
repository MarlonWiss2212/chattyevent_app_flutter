import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/core/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'add_current_user_state.dart';

class AddCurrentUserCubit extends Cubit<AddCurrentUserState> {
  final UserUseCases userUseCases;
  final AuthCubit authCubit;

  AddCurrentUserCubit({
    required this.userUseCases,
    required this.authCubit,
  }) : super(AddCurrentUserState());

  Future createCurrentUser() async {
    emitState(status: AddCurrentUserStateStatus.loading);

    if (state.firstname == null ||
        state.lastname == null ||
        state.username == null ||
        state.birthdate == null) {
      emitState(
        error: ErrorWithTitleAndMessage(
          title: "Ausfüll Fehler",
          message: "Fülle bitte erst alle Felder aus",
        ),
        status: AddCurrentUserStateStatus.error,
      );
    }

    final Either<Failure, UserEntity> userOrFailure =
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
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Fehler Create User",
          message: mapFailureToMessage(error),
        ),
        status: AddCurrentUserStateStatus.error,
      ),
      (user) {
        authCubit.emitState(
          currentUser: user,
          status: AuthStateStatus.success,
        );
        emit(AddCurrentUserState(
          addedUser: user,
          status: AddCurrentUserStateStatus.success,
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
    ErrorWithTitleAndMessage? error,
  }) {
    emit(AddCurrentUserState(
      profileImage: profileImage ?? state.profileImage,
      firstname: firstname ?? state.firstname,
      lastname: lastname ?? state.lastname,
      username: username ?? state.username,
      birthdate: birthdate ?? state.birthdate,
      error: error ?? state.error,
      status: status ?? AddCurrentUserStateStatus.initial,
    ));
  }
}
