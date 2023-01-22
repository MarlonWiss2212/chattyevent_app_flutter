import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_and_token_entity.dart.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import './../../../one_signal.dart' as one_signal;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCases authUseCases;
  final UserUseCases userUseCases;
  final NotificationUseCases notificationUseCases;
  final UserCubit userCubit;
  final ProfilePageCubit profilePageCubit;

  AuthCubit({
    required this.authUseCases,
    required this.userUseCases,
    required this.notificationUseCases,
    required this.userCubit,
    required this.profilePageCubit,
  }) : super(AuthInitial());

  Future login({required String email, required String password}) async {
    emit(AuthLoading());

    final Either<Failure, UserAndTokenEntity> authOrFailure =
        await authUseCases.login(
      email,
      password,
    );

    authOrFailure.fold(
      (error) => emit(
        AuthError(
          tokenError: false,
          title: "Login Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (userAndToken) async {
        emit(AuthLoaded(
          token: userAndToken.accessToken,
        ));

        userCubit.editUserIfExistOrAdd(user: userAndToken.user);

        await one_signal.setExternalUserId(
          Jwt.parseJwt(userAndToken.accessToken)["sub"],
        );
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future register({required CreateUserDto createUserDto}) async {
    emit(AuthLoading());

    final Either<Failure, UserAndTokenEntity> authOrFailure =
        await authUseCases.register(createUserDto);

    authOrFailure.fold(
      (error) => emit(
        AuthError(
          tokenError: false,
          title: "Registrier Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (userAndToken) async {
        emit(AuthLoaded(
          token: userAndToken.accessToken,
        ));

        userCubit.editUserIfExistOrAdd(user: userAndToken.user);

        await notificationUseCases.requestNotificationPermission();
        await one_signal.setExternalUserId(
          Jwt.parseJwt(userAndToken.accessToken)["sub"],
        );
      },
    );
  }

  Future getTokenAndLoadUser() async {
    emit(AuthLoading());

    final Either<Failure, String> authTokenOrFailure =
        await authUseCases.getAuthTokenFromStorage();

    await authTokenOrFailure.fold(
      (error) async {
        emit(AuthError(
          tokenError: true,
          title: "Kein Access Token",
          message: mapFailureToMessage(error),
        ));
      },
      (token) async {
        emit(AuthLoaded(
          token: token,
        ));

        profilePageCubit.getOneUserViaApi(
          getOneUserFilter: GetOneUserFilter(
            id: Jwt.parseJwt(token)["sub"],
          ),
        );
      },
    );
  }

  Future logout() async {
    await authUseCases.logout();
    emit(AuthInitial());
  }
}
