import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final UserUseCases userUseCases;
  final UserCubit userCubit;
  ProfilePageCubit(
    super.initialState, {
    required this.userUseCases,
    required this.userCubit,
  });

  Future getOneUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    emit(ProfilePageLoading(user: state.user));
    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );

    userOrFailure.fold(
      (error) {
        emit(ProfilePageError(
          user: state.user,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (user) {
        final mergedUser = userCubit.editUserIfExistOrAdd(user: user);
        emit(ProfilePageLoaded(user: mergedUser));
      },
    );
  }

  void setCurrentUserFromAnotherResponse({
    required UserEntity user,
  }) {
    emit(ProfilePageLoading(user: state.user));

    final mergedUser = userCubit.editUserIfExistOrAdd(user: user);
    emit(ProfilePageLoaded(user: mergedUser));
  }
}
