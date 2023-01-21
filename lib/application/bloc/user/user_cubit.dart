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

  UserEntity? getUserById({required String userId}) {
    if (state is UserStateLoaded) {
      final state = this.state as UserStateLoaded;
      for (final user in state.users) {
        if (user.id == userId) {
          return user;
        }
      }
    }
    return null;
  }

  void editUserIfExistOrAdd({required UserEntity user}) {
    if (state is UserStateLoaded) {
      final state = this.state as UserStateLoaded;

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
          emailVerified:
              user.emailVerified ?? newUsers[foundIndex].emailVerified,
          profileImageLink:
              user.profileImageLink ?? newUsers[foundIndex].profileImageLink,
          firstname: user.firstname ?? newUsers[foundIndex].firstname,
          lastname: user.lastname ?? newUsers[foundIndex].lastname,
          birthdate: user.birthdate ?? newUsers[foundIndex].birthdate,
          lastTimeOnline:
              user.lastTimeOnline ?? newUsers[foundIndex].lastTimeOnline,
          createdAt: user.createdAt ?? newUsers[foundIndex].createdAt,
        );
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

  Future getUsersViaApi({
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
}
