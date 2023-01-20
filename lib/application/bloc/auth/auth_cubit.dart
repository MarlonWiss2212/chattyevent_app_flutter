import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_and_token_entity.dart.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/injection.dart';
import './../../../one_signal.dart' as one_signal;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthUseCases authUseCases;
  UserUseCases userUseCases;
  NotificationUseCases notificationUseCases;
  UserCubit userCubit;

  AuthCubit({
    required this.authUseCases,
    required this.userUseCases,
    required this.userCubit,
    required this.notificationUseCases,
  }) : super(AuthInitial());

  Future login({required String email, required String password}) async {
    emit(AuthStateLoadingToken());

    final Either<Failure, UserAndTokenEntity> authOrFailure =
        await authUseCases.login(
      email,
      password,
    );

    authOrFailure.fold(
      (error) => emit(
        AuthStateError(
          title: "Login Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (userAndToken) async {
        emit(AuthStateLoaded(userAndToken: userAndToken));
        userCubit.checkIfUserExistOrAddIt(user: userAndToken.user);
        await one_signal.setExternalUserId(
          Jwt.parseJwt(userAndToken.accessToken)["sub"],
        );
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future register({required CreateUserDto createUserDto}) async {
    emit(AuthStateLoadingToken());

    final Either<Failure, UserAndTokenEntity> authOrFailure =
        await authUseCases.register(createUserDto);

    authOrFailure.fold(
      (error) => emit(
        AuthStateError(
          title: "Registrier Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (userAndToken) async {
        emit(AuthStateLoaded(userAndToken: userAndToken));
        userCubit.checkIfUserExistOrAddIt(user: userAndToken.user);
        await notificationUseCases.requestNotificationPermission();
        await one_signal.setExternalUserId(
          Jwt.parseJwt(userAndToken.accessToken)["sub"],
        );
      },
    );
  }

  Future getToken() async {
    emit(AuthStateLoadingToken());

    final Either<Failure, String> authTokenOrFailure =
        await authUseCases.getAuthTokenFromStorage();

    await authTokenOrFailure.fold(
      (error) {
        emit(AuthStateError(
          title: "Kein Access Token",
          message: mapFailureToMessage(error),
        ));
      },
      (token) async {
        emit(AuthStateLoadingCurrentUser());
        // make this new
        userUseCases = serviceLocator();
        authUseCases = serviceLocator();
        notificationUseCases = serviceLocator();
        userCubit = serviceLocator();

        final Either<Failure, UserEntity> userOrFailure =
            await userUseCases.getUserViaApi(
          getOneUserFilter: GetOneUserFilter(
            id: Jwt.parseJwt(token)["sub"],
          ),
        );
        userOrFailure.fold(
          (error) {
            emit(AuthStateError(
              title: "User nicht gefunden",
              message: mapFailureToMessage(error),
            ));
          },
          (user) {
            userCubit.checkIfUserExistOrAddIt(user: user);
            emit(
              AuthStateLoaded(
                userAndToken: UserAndTokenEntity(
                  accessToken: token,
                  user: user,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future logout() async {
    await authUseCases.logout();
    emit(AuthInitial());
  }
}
