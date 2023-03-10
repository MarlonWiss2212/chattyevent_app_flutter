import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final FirebaseAuth auth;
  final UserUseCases userUseCases;
  final UserCubit userCubit;
  ProfilePageCubit(
    super.initialState, {
    required this.auth,
    required this.userUseCases,
    required this.userCubit,
  });

  Future getCurrentUserViaApi() async {
    emitState(status: ProfilePageStateStatus.loading);
    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: GetOneUserFilter(
        id: state.user.id != "" ? state.user.id : null,
        authId: state.user.id != "" ? null : state.user.authId,
      ),
    );

    userOrFailure.fold(
      (error) {
        emitState(
          status: ProfilePageStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Get User Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (user) {
        final mergedUser = userCubit.mergeOrAdd(user: user);
        emitState(status: ProfilePageStateStatus.success, user: mergedUser);
      },
    );
  }

  emitState({
    UserEntity? user,
    ErrorWithTitleAndMessage? error,
    ProfilePageStateStatus? status,
  }) {
    emit(ProfilePageState(
      user: user ?? state.user,
      error: error ?? state.error,
      status: status ?? state.status,
    ));
  }
}
