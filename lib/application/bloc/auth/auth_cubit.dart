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
  final AuthUseCases authUseCases;
  final UserUseCases userUseCases;
  final NotificationUseCases notificationUseCases;

  AuthCubit({
    required this.authUseCases,
    required this.userUseCases,
    required this.notificationUseCases,
  }) : super(AuthState());

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
          user: authUser.user,
          token: await authUser.user?.getIdToken(),
        );
        await one_signal.setExternalUserId(authUser.user!.uid);
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
          user: authUser.user,
          token: await authUser.user?.getIdToken(),
        );
        await one_signal.setExternalUserId(authUser.user!.uid);
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future sendEmailVerification() async {
    if (state.user != null) {
      return await authUseCases.sendEmailVerification(authUser: state.user!);
    }
  }

  Future logout() async {
    await authUseCases.logout();
    emit(AuthState());
  }

  Future setAuthData() async {
    final authUser = FirebaseAuth.instance.currentUser;
    emitState(
      user: authUser,
      token: await authUser?.getIdToken(),
      status: AuthStateStatus.success,
    );
  }

  void emitState({
    AuthStateStatus? status,
    ErrorWithTitleAndMessage? error,
    User? user,
    String? token,
  }) {
    emit(AuthState(
      error: state.error ?? state.error,
      status: status ?? AuthStateStatus.initial,
      user: user ?? state.user,
      token: token ?? state.token,
    ));
  }
}
