import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases userUseCases;

  UserBloc({required this.userUseCases}) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});

    on<UserInitialEvent>((event, emit) {
      emit(UserInitial());
    });

    on<GetOneUserEvent>((event, emit) async {
      final Either<Failure, UserEntity> userOrFailure =
          await userUseCases.getUserViaApi(
        getOneUserFilter: event.getOneUserFilter,
      );

      userOrFailure.fold(
        (error) {
          if (state is UserStateLoaded) {
            final state = this.state as UserStateLoaded;
            emit(
              UserStateLoaded(
                users: state.users,
                errorMessage: mapFailureToMessage(error),
              ),
            );
          } else {
            emit(
              UserStateError(
                message: mapFailureToMessage(error),
              ),
            );
          }
        },
        (user) {
          if (state is UserStateLoaded) {
            final state = this.state as UserStateLoaded;

            int foundIndex = -1;
            state.users.asMap().forEach((index, userToFind) {
              if (userToFind.id == user.id) {
                foundIndex = index;
              }
            });

            if (foundIndex != -1) {
              List<UserEntity> newUsers = state.users;
              newUsers[foundIndex] = user;
              emit(
                UserStateLoaded(users: newUsers),
              );
            } else {
              emit(
                UserStateLoaded(users: List.from(state.users)..add(user)),
              );
            }
          } else {
            emit(
              UserStateLoaded(
                users: [user],
              ),
            );
          }
        },
      );
    });
    on<GetUsersEvent>((event, emit) async {
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
