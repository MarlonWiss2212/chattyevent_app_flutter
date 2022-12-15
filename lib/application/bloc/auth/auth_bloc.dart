import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases authUseCases;

  AuthBloc({required this.authUseCases}) : super(AuthInitial()) {
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
        (token) => emit(AuthStateLoaded(token: token)),
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
        (token) => emit(AuthStateLoaded(token: token)),
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
