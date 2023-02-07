import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'home_profile_page_state.dart';

class HomeProfilePageCubit extends Cubit<HomeProfilePageState> {
  final UserUseCases userUseCases;
  HomeProfilePageCubit(
    super.initialState, {
    required this.userUseCases,
  });

  Future getOneUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    emit(HomeProfilePageLoading(user: state.user));

    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );

    userOrFailure.fold(
      (error) {
        emit(HomeProfilePageError(
          user: state.user,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (user) {
        emit(HomeProfilePageLoaded(user: user));
      },
    );
  }
}
