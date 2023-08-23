import 'dart:async';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';
import '../../../core/utils/one_signal_utils.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCases authUseCases;
  final FirebaseAuth auth;
  final PermissionUseCases permissionUseCases;
  final NotificationCubit notificationCubit;
  UserUseCases userUseCases;

  AuthCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.authUseCases,
    required this.auth,
    required this.userUseCases,
    required this.permissionUseCases,
  });

  Future setCurrentUserFromFirebaseViaApi() async {
    if (auth.currentUser == null) {
      return;
    }

    final Either<NotificationAlert, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      currentUser: true,
      findOneUserFilter: FindOneUserFilter(authId: auth.currentUser!.uid),
    );

    await userOrFailure.fold(
      (alert) {
        emitState(userException: alert.exception);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (user) async {
        emitState(currentUser: user);
        await OneSignalUtils.setExternalUserId(user.id);
      },
    );
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (state.dataprotectionCheckbox == false) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Datenschutz Fehler",
          message:
              "Du musst den Datenschutzbestimmungen zustimmen um dich anzumelden",
        ),
      );
      return;
    }
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
          status: AuthStateStatus.loggedIn,
          token: await authUser.user?.getIdToken(),
        );
        await setCurrentUserFromFirebaseViaApi();
        await permissionUseCases.requestNotificationPermission();
      },
    );
  }

  Future registerWithEmailAndPassword({
    required String email,
    required String password,
    required String verifyPassword,
  }) async {
    if (password != verifyPassword) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Passwort Fehler",
          message: "Die Passwörter müssen identisch sein",
        ),
      );
      return;
    }
    if (state.dataprotectionCheckbox == false) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Datenschutz Fehler",
          message:
              "Du musst den Datenschutzbestimmungen zustimmen um dich anzumelden",
        ),
      );
      return;
    }
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
          status: AuthStateStatus.loggedIn,
          token: await authUser.user?.getIdToken(),
        );
        await permissionUseCases.requestNotificationPermission();
      },
    );
  }

  Future sendEmailVerification() async {
    Either<NotificationAlert, Unit> sendEmailOrFailure =
        await authUseCases.sendEmailVerification();

    sendEmailOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (_) {
        emitState(sendedVerificationEmail: true);
      },
    );
  }

  Future sendResetPasswordEmail({String? email}) async {
    Either<NotificationAlert, String> sendEmailOrFailure =
        await authUseCases.sendResetPasswordEmail(email: email);

    sendEmailOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (newEmail) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "Email gesendet",
            message:
                "Die Password zurücksetye E-Mail wurde an die folgende E-Mail gesendet: $newEmail",
            snackbar: true,
          ),
        );
      },
    );
  }

  Future updatePassword({
    required String password,
    required String verifyPassword,
  }) async {
    Either<NotificationAlert, Unit> updatedPassowrdOrFailure =
        await authUseCases.updatePassword(
      password: password,
      verfiyPassword: verifyPassword,
    );

    updatedPassowrdOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (_) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "Passwort aktualisiert",
            message: "Dein Passwort wurde erfolgreich aktualisiert",
            snackbar: true,
          ),
        );
      },
    );
  }

  Future verifyBeforeUpdateEmail({
    required String email,
    required String verifyEmail,
  }) async {
    Either<NotificationAlert, Unit> updatedEmailOrFailure =
        await authUseCases.verifyBeforeUpdateEmail(
      email: email,
      verifyEmail: verifyEmail,
    );

    updatedEmailOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (_) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "E-Mail Bestätigung gesendet",
            message: "Deine E-Mail wird aktualisiert sobald du sie Bestätigst",
            snackbar: true,
          ),
        );
      },
    );
  }

  Future refreshAuthToken() async {
    final token = await authUseCases.refreshToken();
    token.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (token) => token != state.token ? emitState(token: token) : null,
    );
  }

  Future refreshUser() async {
    return await authUseCases.refreshUser();
  }

  Future logout() async {
    emitState(status: AuthStateStatus.loading);
    await authUseCases.logout();
    emit(AuthState(
      currentUser: UserEntity(authId: "", id: ""),
      status: AuthStateStatus.logout,
    ));
  }

  Future updateUser({
    required UpdateUserDto updateUserDto,
  }) async {
    final userOrFailure = await userUseCases.updateUserViaApi(
      updateUserDto: updateUserDto,
    );

    userOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(userException: alert.exception);
      },
      (user) {
        final newUser = UserEntity.merge(
          newEntity: user,
          oldEntity: state.currentUser,
        );
        emitState(currentUser: newUser);
      },
    );
  }

  Future deleteUser() async {
    final deletedOrAlert = await authUseCases.deleteUser();

    deletedOrAlert.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (worked) {
        userUseCases.deleteUserViaApi();
        emit(AuthState(
          currentUser: UserEntity(authId: "", id: ""),
          status: AuthStateStatus.logout,
        ));
      },
    );
  }

  void emitState({
    AuthStateStatus? status,
    String? token,
    UserEntity? currentUser,
    bool? sendedVerificationEmail,
    bool? dataprotectionCheckbox,
    OperationException? userException,
    bool resetUserException = false,
  }) {
    emit(AuthState(
      status: status ?? AuthStateStatus.initial,
      token: token ?? state.token,
      currentUser: currentUser ?? state.currentUser,
      sendedVerificationEmail: sendedVerificationEmail ?? false,
      dataprotectionCheckbox:
          dataprotectionCheckbox ?? state.dataprotectionCheckbox,
      userException:
          resetUserException ? null : userException ?? state.userException,
    ));
    if (token != null) {
      userUseCases = serviceLocator(param1: state);
    }
  }
}
