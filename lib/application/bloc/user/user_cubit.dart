import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUseCases userUseCases;

  UserCubit({required this.userUseCases}) : super(UserInitial());

  UserEntity replaceOrAdd({required UserEntity user}) {
    int foundIndex = state.users.indexWhere((element) => element.id == user.id);

    if (foundIndex != -1) {
      List<UserEntity> newUsers = state.users;
      newUsers[foundIndex] = user;
      emit(UserStateLoaded(users: newUsers));
      return newUsers[foundIndex];
    } else {
      emit(
        UserStateLoaded(
          users: List.from(state.users)..add(user),
        ),
      );
    }
    return user;
  }

  List<UserEntity> replaceOrAddMultiple({
    required List<UserEntity> users,
  }) {
    List<UserEntity> mergedUsers = [];
    for (final user in users) {
      // state will be changed in mergeOrAdd
      final mergedUser = replaceOrAdd(user: user);
      mergedUsers.add(mergedUser);
    }
    if (users.isEmpty) {
      emit(const UserStateLoaded(users: []));
    }
    return mergedUsers;
  }

  void delete({required String userId}) {
    List<UserEntity> newUsers = state.users;
    newUsers.removeWhere(
      (element) => element.id == userId,
    );
    emit(UserStateLoaded(users: newUsers));
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
        replaceOrAddMultiple(users: users);
      },
    );
  }
}
