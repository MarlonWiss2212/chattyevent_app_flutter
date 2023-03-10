import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  final UserUseCases userUseCases;

  UserSearchCubit({required this.userUseCases}) : super(UserSearchInitial());
  void reset() {
    emit(UserSearchInitial());
  }

  Future getUsersViaApi({
    GetUsersFilter? getUsersFilter,
  }) async {
    emit(UserSearchStateLoading());

    final Either<Failure, List<UserEntity>> userSearchOrFailure =
        await userUseCases.getUsersViaApi(
      getUsersFilter: getUsersFilter ?? GetUsersFilter(),
    );

    userSearchOrFailure.fold(
      (error) => emit(
        UserSearchStateError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (users) => emit(
        UserSearchStateLoaded(users: users),
      ),
    );
  }
}
