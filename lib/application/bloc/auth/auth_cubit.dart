import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/core/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_and_token_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import '../../../core/one_signal.dart' as one_signal;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCases authUseCases;
  final UserUseCases userUseCases;
  final NotificationUseCases notificationUseCases;

  AuthCubit({
    required this.authUseCases,
    required this.userUseCases,
    required this.notificationUseCases,
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
          userResponse: userAndToken.user,
        ));

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
          userResponse: userAndToken.user,
        ));

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
      },
    );
  }

  Future logout() async {
    await authUseCases.logout();
    emit(AuthInitial());
  }
}
