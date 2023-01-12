import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import './../../../one_signal.dart' as one_signal;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases authUseCases;
  final NotificationUseCases notificationUseCases;

  AuthBloc({
    required this.authUseCases,
    required this.notificationUseCases,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthStateLoading());

      final Either<Failure, String> authTokenOrFailure =
          await authUseCases.login(event.email, event.password);

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
    });
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthStateLoading());

      final Either<Failure, String> authTokenOrFailure =
          await authUseCases.register(event.createUserDto);

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
    });
    on<AuthGetTokenEvent>((event, emit) async {
      emit(AuthStateLoading());

      final Either<Failure, String> authTokenOrFailure =
          await authUseCases.getAuthTokenFromStorage();

      authTokenOrFailure.fold(
        (error) => emit(
          AuthStateError(message: mapFailureToMessage(error)),
        ),
        (token) => emit(AuthStateLoaded(token: token)),
      );
    });
    on<AuthLogoutEvent>((event, emit) async {
      await authUseCases.logout();
      emit(AuthInitial());
    });
  }
}
