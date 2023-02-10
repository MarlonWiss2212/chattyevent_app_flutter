import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
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
    emit(CurrentUserNormal(user: state.user, loadingUser: true));

    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );

    userOrFailure.fold(
      (error) {
        emit(CurrentUserError(
          user: state.user,
          title: "Fehler",
          message: mapFailureToMessage(error),
          loadingUser: false,
        ));
      },
      (user) {
        emit(CurrentUserNormal(user: user, loadingUser: false));
      },
    );
  }
}
