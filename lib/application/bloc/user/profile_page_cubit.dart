import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_all_follower_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final AuthCubit authCubit;

  final UserRelationUseCases userRelationUseCases;
  final UserUseCases userUseCases;
  final UserCubit userCubit;
  ProfilePageCubit(
    super.initialState, {
    required this.authCubit,
    required this.userRelationUseCases,
    required this.userUseCases,
    required this.userCubit,
  });

  Future getCurrentUserViaApi() async {
    emitState(status: ProfilePageStateStatus.loading);
    final Either<Failure, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      getOneUserFilter: GetOneUserFilter(
        id: state.user.id != "" ? state.user.id : null,
        authId: state.user.id != "" &&
                state.user.authId == authCubit.state.currentUser.authId
            ? authCubit.state.currentUser.authId
            : null,
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
        if (state.user.authId == authCubit.state.currentUser.authId) {
          authCubit.emitState(currentUser: mergedUser);
        }
        emitState(status: ProfilePageStateStatus.success, user: mergedUser);
      },
    );
  }

  Future getFollowerUserRelationsViaApi() async {
    emitState(userRelationStatus: ProfilePageStateUserRelationStatus.loading);

    final Either<Failure, List<UserRelationEntity>> userOrFailure =
        await userRelationUseCases.getFollowerUserRelationsViaApi(
      findAllFollowerUserRelationFilter: FindAllFollowerUserRelationFilter(
        userId: state.user.id,
      ),
    );

    userOrFailure.fold(
      (error) {
        emitState(
          userRelationStatus: ProfilePageStateUserRelationStatus.error,
          errorRelationError: ErrorWithTitleAndMessage(
            title: "Get User Relation Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (userRelation) {
        emitState(
          userRelationStatus: ProfilePageStateUserRelationStatus.success,
          userRelations: userRelation,
        );
      },
    );
  }

  Future followOrUnfollowUserViaApi() async {
    emitState(userRelationStatus: ProfilePageStateUserRelationStatus.loading);

    final userRelationOrFailure =
        await userRelationUseCases.followOrUnfollowUserViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        requesterUserId: authCubit.state.currentUser.id,
        targetUserId: state.user.id,
      ),
      userRelationEntity: state.user.myUserRelationToTheUser,
    );

    userRelationOrFailure.fold(
      (error) => emitState(
        userRelationStatus: ProfilePageStateUserRelationStatus.error,
        errorRelationError: ErrorWithTitleAndMessage(
          title: "Follow Or Unfollow Failure",
          message: mapFailureToMessage(error),
        ),
      ),
      (booleanOrUserRelation) {
        booleanOrUserRelation.fold(
          (userRelation) {
            emitState(
              userRelationStatus: ProfilePageStateUserRelationStatus.success,
              userRelations: List.from(state.userRelations ?? [])
                ..add(userRelation),
              user: UserEntity.merge(
                newEntity: UserEntity(
                  id: state.user.id,
                  authId: state.user.authId,
                  myUserRelationToTheUser: userRelation,
                  userRelationCounts: UserRelationsCountEntity(
                    followerCount: state.user.userRelationCounts != null &&
                            state.user.userRelationCounts!.followerCount != null
                        ? state.user.userRelationCounts!.followerCount! + 1
                        : 0,
                  ),
                ),
                oldEntity: state.user,
              ),
            );
          },
          (boolean) {
            if (boolean == false) {
              return;
            }
            emitState(
              userRelationStatus: ProfilePageStateUserRelationStatus.success,
              userRelations: List.from(state.userRelations ?? [])
                ..removeWhere(
                  (element) =>
                      element.requesterUserId == authCubit.state.currentUser.id,
                ),
              user: UserEntity.merge(
                removeUserRelation: true,
                newEntity: UserEntity(
                  id: state.user.id,
                  authId: state.user.authId,
                  userRelationCounts: UserRelationsCountEntity(
                    followerCount: state.user.userRelationCounts != null &&
                            state.user.userRelationCounts!.followerCount !=
                                null &&
                            state.user.userRelationCounts!.followerCount! > 0
                        ? state.user.userRelationCounts!.followerCount! - 1
                        : 0,
                  ),
                ),
                oldEntity: state.user,
              ),
            );
          },
        );
      },
    );
  }

  emitState({
    UserEntity? user,
    ErrorWithTitleAndMessage? error,
    ProfilePageStateStatus? status,
    ProfilePageStateUserRelationStatus? userRelationStatus,
    List<UserRelationEntity>? userRelations,
    ErrorWithTitleAndMessage? errorRelationError,
  }) {
    emit(
      ProfilePageState(
        user: user ?? state.user,
        error: error ?? state.error,
        status: status ?? ProfilePageStateStatus.initial,
        userRelationStatus:
            userRelationStatus ?? ProfilePageStateUserRelationStatus.initial,
        userRelations: userRelations ?? state.userRelations,
        errorRelationError: errorRelationError ?? state.errorRelationError,
      ),
    );
  }
}
