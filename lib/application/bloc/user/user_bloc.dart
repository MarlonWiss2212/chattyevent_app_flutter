import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases userUseCases;

  UserBloc({required this.userUseCases}) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<UserRequestEvent>((event, emit) async {
      emit(UserStateLoading());

      final Either<Failure, List<UserEntity>> usersOrFailure =
          await userUseCases.getUsersViaApi("");

      usersOrFailure.fold(
        (error) => emit(UserStateError(
          message: mapFailureToMessage(error),
        )),
        (users) => emit(
          UserStateLoaded(users: users),
        ),
      );
    });
  }
}
