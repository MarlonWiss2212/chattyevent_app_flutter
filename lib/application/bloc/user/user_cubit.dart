import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUseCases userUseCases;

  UserCubit({required this.userUseCases}) : super(UserInitial());

  void reset() {
    emit(UserInitial());
  }

  Future getUsers({
    GetUsersFilter? getUsersFilter,
  }) async {
    emit(UserStateLoading());

    final Either<Failure, List<UserEntity>> userSearchOrFailure =
        await userUseCases.getUsersViaApi(
      getUsersFilter: getUsersFilter ?? GetUsersFilter(),
    );

    userSearchOrFailure.fold(
      (error) => emit(
        UserStateError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (users) => emit(
        UserStateLoaded(users: users),
      ),
    );
  }

  Future getOneUser({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
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
              title: "Fehler",
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
  }

  void checkIfUserExistOrAddIt({required UserEntity user}) {
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
  }
}
