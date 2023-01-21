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
  ProfilePageCubit({
    required this.userUseCases,
    required this.userCubit,
  }) : super(ProfilePageInitial());

  Future getOneUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    emit(ProfilePageLoading());
    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );

    userOrFailure.fold(
      (error) {
        emit(ProfilePageError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (user) {
        userCubit.editUserIfExistOrAdd(user: user);
        emit(ProfilePageLoaded());
      },
    );
  }
}
