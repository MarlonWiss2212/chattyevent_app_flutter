import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/update_password_page.dart';
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
          title: "Registrier Fehler",
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
    emitState(status: AuthStateStatus.loading);

    Either<Failure, bool> sendEmailOrFailure =
        await authUseCases.sendEmailVerification();

    sendEmailOrFailure.fold(
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Fehler Senden der Email",
          message: mapFailureToMessage(error),
        ),
        status: AuthStateStatus.error,
      ),
      (worked) {
        emitState(
          status: AuthStateStatus.sendedVerificationEmail,
        );
      },
    );
  }

  Future sendResetPasswordEmail({
    required String email,
  }) async {
    emitState(status: AuthStateStatus.loading);
    Either<Failure, bool> sendEmailOrFailure =
        await authUseCases.sendResetPasswordEmail(email: email);

    sendEmailOrFailure.fold(
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Fehler Senden der Passwort Email",
          message: mapFailureToMessage(error),
        ),
        status: AuthStateStatus.error,
      ),
      (worked) {
        emitState(
          status: AuthStateStatus.sendedResetPasswordEmail,
        );
      },
    );
  }

  Future updatePassword({
    required String password,
    required String verifyPassword,
  }) async {
    emitState(status: AuthStateStatus.loading);

    Either<Failure, bool> updatedPassowrdOrFailure = await authUseCases
        .updatePassword(password: password, verfiyPassword: verifyPassword);

    updatedPassowrdOrFailure.fold(
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Fehler Update Passwort",
          message: mapFailureToMessage(error),
        ),
        status: AuthStateStatus.error,
      ),
      (worked) {
        emitState(
          status: AuthStateStatus.sendedResetPasswordEmail,
        );
      },
    );
  }

  Future reloadUser() async {
    return await authUseCases.reloadUser();
  }

  Future logout() async {
    emitState(status: AuthStateStatus.loading);
    await authUseCases.logout();
    emit(AuthState());
  }

  void emitState({
    AuthStateStatus? status,
    ErrorWithTitleAndMessage? error,
    String? token,
  }) {
    emit(AuthState(
      error: error ?? state.error,
      status: status ?? AuthStateStatus.initial,
      token: token ?? state.token,
    ));
  }
}
