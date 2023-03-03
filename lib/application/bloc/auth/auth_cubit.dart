import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import '../../../core/one_signal.dart' as one_signal;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth;
  final AuthUseCases authUseCases;
  final UserUseCases userUseCases;
  final NotificationUseCases notificationUseCases;

  AuthCubit(
    super.initialState, {
    required this.auth,
    required this.authUseCases,
    required this.userUseCases,
    required this.notificationUseCases,
  });

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emitState(status: AuthStateStatus.loading);

    final Either<String, UserCredential> authUserOrFailureString =
        await authUseCases.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    authUserOrFailureString.fold(
      (errorMsg) => emitState(
        status: AuthStateStatus.error,
        error: ErrorWithTitleAndMessage(
          message: errorMsg,
          title: "Login Fehler",
        ),
      ),
      (authUser) async {
        emitState(
          status: AuthStateStatus.success,
          token: await authUser.user?.getIdToken(),
        );
        await one_signal.setExternalUserId(authUser.user?.uid ?? "");
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emitState(status: AuthStateStatus.loading);

    final Either<String, UserCredential> authUserOrFailureString =
        await authUseCases.registerWithEmailAndPassword(
      email: email,
      password: password,
    );

    authUserOrFailureString.fold(
      (errorMsg) => emitState(
        status: AuthStateStatus.error,
        error: ErrorWithTitleAndMessage(
          message: errorMsg,
          title: "Login Fehler",
        ),
      ),
      (authUser) async {
        emitState(
          status: AuthStateStatus.success,
          token: await authUser.user?.getIdToken(),
        );
        await one_signal.setExternalUserId(authUser.user?.uid ?? "");
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future sendEmailVerification() async {
    if (auth.currentUser != null) {
      return await authUseCases.sendEmailVerification(
        authUser: auth.currentUser!,
      );
    }
  }

  Future reloadUser() async {
    return await authUseCases.reloadUser();
  }

  Future logout() async {
    await authUseCases.logout();
    emit(AuthState());
  }

  void emitState({
    AuthStateStatus? status,
    ErrorWithTitleAndMessage? error,
    String? token,
  }) {
    emit(AuthState(
      error: state.error ?? state.error,
      status: status ?? AuthStateStatus.initial,
      token: token ?? state.token,
    ));
  }
}
