import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user/find_one_user_filter.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import '../../../core/one_signal.dart' as one_signal;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth;
  final AuthUseCases authUseCases;
  final NotificationUseCases notificationUseCases;
  final NotificationCubit notificationCubit;
  UserUseCases userUseCases;

  AuthCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.auth,
    required this.authUseCases,
    required this.userUseCases,
    required this.notificationUseCases,
  });

  Future setCurrentUserFromFirebaseViaApi() async {
    if (auth.currentUser == null) {
      return;
    }
    emitState(status: AuthStateStatus.loading);

    final Either<NotificationAlert, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      findOneUserFilter: FindOneUserFilter(authId: auth.currentUser!.uid),
    );

    await userOrFailure.fold(
      (alert) {
        emitState(goOnCreateUserPage: true);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (user) async {
        emitState(currentUser: user, status: AuthStateStatus.success);
        await one_signal.setExternalUserId(user.id);
      },
    );
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emitState(status: AuthStateStatus.loading);

    final Either<NotificationAlert, UserCredential> authUserOrFailureString =
        await authUseCases.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    authUserOrFailureString.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AuthStateStatus.initial);
      },
      (authUser) async {
        emitState(
          status: AuthStateStatus.success,
          token: await authUser.user?.getIdToken(),
        );
        await setCurrentUserFromFirebaseViaApi();
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emitState(status: AuthStateStatus.loading);

    final Either<NotificationAlert, UserCredential> authUserOrFailureString =
        await authUseCases.registerWithEmailAndPassword(
      email: email,
      password: password,
    );

    authUserOrFailureString.fold(
      (alert) {
        emitState(status: AuthStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (authUser) async {
        emitState(
          status: AuthStateStatus.success,
          token: await authUser.user?.getIdToken(),
        );
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future sendEmailVerification() async {
    emitState(status: AuthStateStatus.loading);

    Either<NotificationAlert, bool> sendEmailOrFailure =
        await authUseCases.sendEmailVerification();

    sendEmailOrFailure.fold(
      (alert) {
        emitState(status: AuthStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (worked) {
        emitState(
          status: AuthStateStatus.success,
          sendedVerificationEmail: true,
        );
      },
    );
  }

  Future sendResetPasswordEmail({
    required String email,
  }) async {
    emitState(status: AuthStateStatus.loading);
    Either<NotificationAlert, bool> sendEmailOrFailure =
        await authUseCases.sendResetPasswordEmail(email: email);

    sendEmailOrFailure.fold(
      (alert) {
        emitState(status: AuthStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (worked) {
        emitState(
          status: AuthStateStatus.success,
          sendedResetPasswordEmail: true,
        );
      },
    );
  }

  Future updatePassword({
    required String password,
    required String verifyPassword,
  }) async {
    emitState(status: AuthStateStatus.loading);

    Either<NotificationAlert, bool> updatedPassowrdOrFailure =
        await authUseCases.updatePassword(
            password: password, verfiyPassword: verifyPassword);

    updatedPassowrdOrFailure.fold(
      (alert) {
        emitState(status: AuthStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (worked) {
        emitState(
          status: AuthStateStatus.success,
        );
      },
    );
  }

  Future refreshUser() async {
    return await authUseCases.refreshUser();
  }

  Future logout() async {
    emitState(status: AuthStateStatus.loading);
    await authUseCases.logout();
    emit(AuthState(currentUser: UserEntity(authId: "", id: "")));
  }

  Future deleteUser() async {
    if (auth.currentUser == null) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler User Löschen",
          message: "Fehler beim Identifizierens des gerdigen Users",
        ),
      );
      return;
    }
    emitState(status: AuthStateStatus.loading);
    await Future.wait([
      authUseCases.logout(),
      userUseCases.deleteUserViaApi(),
    ]);
    emit(AuthState(currentUser: UserEntity(authId: "", id: "")));
  }

  Future refreshJwtToken() async {
    final Either<NotificationAlert, String> newTokenOrFailure =
        await authUseCases.refreshToken();

    newTokenOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (token) {
        emitState(token: token);
      },
    );
  }

  Future checkIfEmailVerfiedIfSoCreateUserPage() async {
    if (auth.currentUser != null && auth.currentUser!.emailVerified) {
      emitState(goOnCreateUserPage: true);
    }
  }

  void emitState(
      {AuthStateStatus? status,
      String? token,
      UserEntity? currentUser,
      bool? sendedResetPasswordEmail,
      bool? sendedVerificationEmail,
      bool? goOnCreateUserPage}) {
    emit(AuthState(
        status: status ?? AuthStateStatus.initial,
        token: token ?? state.token,
        currentUser: currentUser ?? state.currentUser,
        sendedResetPasswordEmail: sendedResetPasswordEmail ?? false,
        sendedVerificationEmail: sendedVerificationEmail ?? false,
        goOnCreateUserPage: goOnCreateUserPage ?? false));
    if (token != null) {
      userUseCases = serviceLocator(param1: state);
    }
  }
}
