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
  HomeProfilePageCubit({required this.userUseCases})
      : super(HomeProfilePageInitial());

  Future getOneUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    if (state is HomeProfilePageWithUser) {
      final state = this.state as HomeProfilePageWithUser;
      emit(HomeProfilePageEditing(user: state.user));
    } else {
      emit(HomeProfilePageLoading());
    }

    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );

    userOrFailure.fold(
      (error) {
        emit(HomeProfilePageError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (user) {
        emit(HomeProfilePageLoaded(user: user));
      },
    );
  }

  void setCurrentUserFromAnotherResponse({
    required UserEntity user,
  }) {
    if (state is HomeProfilePageWithUser) {
      final state = this.state as HomeProfilePageWithUser;
      emit(HomeProfilePageEditing(user: state.user));
    } else {
      emit(HomeProfilePageLoading());
    }
    emit(HomeProfilePageLoaded(user: user));
  }
}
