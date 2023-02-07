import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUseCases userUseCases;

  UserCubit({required this.userUseCases}) : super(UserInitial());

  void reset() {
    emit(UserInitial());
  }

  UserEntity editUserIfExistOrAdd({required UserEntity user}) {
    int foundIndex = -1;
    state.users.asMap().forEach((index, chatToFind) {
      if (chatToFind.id == user.id) {
        foundIndex = index;
      }
    });

    if (foundIndex != -1) {
      List<UserEntity> newUsers = state.users;
      newUsers[foundIndex] = UserEntity(
        id: user.id,
        username: user.username ?? newUsers[foundIndex].username,
        email: user.email ?? newUsers[foundIndex].email,
        emailVerified: user.emailVerified ?? newUsers[foundIndex].emailVerified,
        profileImageLink:
            user.profileImageLink ?? newUsers[foundIndex].profileImageLink,
        firstname: user.firstname ?? newUsers[foundIndex].firstname,
        lastname: user.lastname ?? newUsers[foundIndex].lastname,
        birthdate: user.birthdate ?? newUsers[foundIndex].birthdate,
        lastTimeOnline:
            user.lastTimeOnline ?? newUsers[foundIndex].lastTimeOnline,
        createdAt: user.createdAt ?? newUsers[foundIndex].createdAt,
      );
      emit(UserStateLoaded(users: newUsers));
      return newUsers[foundIndex];
    } else {
      emit(
        UserStateLoaded(users: List.from(state.users)..add(user)),
      );
    }
    return user;
  }

  Future getUsersViaApi({
    GetUsersFilter? getUsersFilter,
  }) async {
    emit(UserStateLoading(users: state.users));

    final Either<Failure, List<UserEntity>> userSearchOrFailure =
        await userUseCases.getUsersViaApi(
      getUsersFilter: getUsersFilter ?? GetUsersFilter(),
    );

    userSearchOrFailure.fold(
      (error) => emit(
        UserStateError(
          users: state.users,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (users) {
        List<UserEntity> usersToEmit = users;

        for (final stateUser in state.users) {
          bool savedTheUser = false;

          innerLoop:
          for (final userToEmit in usersToEmit) {
            if (userToEmit.id == stateUser.id) {
              savedTheUser = true;
              break innerLoop;
            }
          }

          if (!savedTheUser) {
            usersToEmit.add(stateUser);
          }
        }
        emit(UserStateLoaded(users: users));
      },
    );
  }
}
