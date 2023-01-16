import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import './../../../one_signal.dart' as one_signal;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCases authUseCases;
  final NotificationUseCases notificationUseCases;

  AuthCubit({
    required this.authUseCases,
    required this.notificationUseCases,
  }) : super(AuthInitial());

  Future login({required String email, required String password}) async {
    emit(AuthStateLoading());

    final Either<Failure, String> authTokenOrFailure = await authUseCases.login(
      email,
      password,
    );

    authTokenOrFailure.fold(
      (error) => emit(
        AuthStateError(
          title: "Login Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (token) async {
        emit(AuthStateLoaded(token: token));
        await one_signal.setExternalUserId(Jwt.parseJwt(token)["sub"]);
        await notificationUseCases.requestNotificationPermission();
      },
    );
  }

  Future register({required CreateUserDto createUserDto}) async {
    emit(AuthStateLoading());

    final Either<Failure, String> authTokenOrFailure =
        await authUseCases.register(createUserDto);

    authTokenOrFailure.fold(
      (error) => emit(
        AuthStateError(
          title: "Registrier Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (token) async {
        emit(AuthStateLoaded(token: token));
        await notificationUseCases.requestNotificationPermission();
        await one_signal.setExternalUserId(Jwt.parseJwt(token)["sub"]);
      },
    );
  }

  Future getToken() async {
    emit(AuthStateLoading());

    final Either<Failure, String> authTokenOrFailure =
        await authUseCases.getAuthTokenFromStorage();

    authTokenOrFailure.fold(
      (error) => emit(
        AuthStateError(message: mapFailureToMessage(error)),
      ),
      (token) => emit(
        AuthStateLoaded(token: token),
      ),
    );
  }

  Future logout() async {
    await authUseCases.logout();
    emit(AuthInitial());
  }
}
