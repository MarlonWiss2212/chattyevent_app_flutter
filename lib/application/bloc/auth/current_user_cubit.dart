import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final UserUseCases userUseCases;
  CurrentUserCubit(
    super.initialState, {
    required this.userUseCases,
  });

  Future getOneUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    emitState(status: CurrentUserStateStatus.loading);

    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );

    userOrFailure.fold(
      (error) {
        emitState(
          user: state.user,
          error: ErrorWithTitleAndMessage(
            title: "Fehler Get Current User",
            message: mapFailureToMessage(error),
          ),
          status: CurrentUserStateStatus.error,
        );
      },
      (user) {
        emitState(user: user, status: CurrentUserStateStatus.success);
      },
    );
  }

  void emitState({
    UserEntity? user,
    CurrentUserStateStatus? status,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(CurrentUserState(
      user: user ?? state.user,
      status: status ?? CurrentUserStateStatus.initial,
      error: error ?? state.error,
    ));
  }
}
