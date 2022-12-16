import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final UserUseCases userUseCases;

  UserSearchBloc({required this.userUseCases}) : super(UserSearchInitial()) {
    on<UserSearchEvent>((event, emit) {});

    on<UserSearchInitialEvent>((event, emit) {
      emit(UserSearchInitial());
    });

    on<UserSearchGetUsersEvent>((event, emit) async {
      emit(UserSearchStateLoading());

      final Either<Failure, List<UserEntity>> userSearchOrFailure =
          await userUseCases.getUsersViaApi(
        getUsersFilter: event.getUsersFilter,
      );

      userSearchOrFailure.fold(
        (error) => emit(
          UserSearchStateError(message: mapFailureToMessage(error)),
        ),
        (users) => emit(
          UserSearchStateLoaded(users: users),
        ),
      );
    });
  }
}
