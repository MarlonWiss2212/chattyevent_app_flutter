import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/filter/limit_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/target_user_id_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
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

  Future getFollowers() async {
    const int limit = 30;

    emitState(followersStatus: ProfilePageStateFollowersStatus.loading);

    final Either<Failure, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowersViaApi(
      targetUserIdFilter: TargetUserIdFilter(targetUserId: state.user.id),
      limitFilter: LimitFilter(limit: limit, offset: state.followersOffset),
    );

    userOrFailure.fold(
      (error) {
        emitState(
          followersStatus: ProfilePageStateFollowersStatus.error,
          followersError: ErrorWithTitleAndMessage(
            title: "Get User Relation Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (users) {
        emitState(
          followersOffset: state.followersOffset + limit,
          followersStatus: ProfilePageStateFollowersStatus.success,
          followers: List.from(state.followers ?? [])..addAll(users),
        );
      },
    );
  }

  /// fix the response of this
  Future acceptFollowRequest({
    required RequestUserIdFilter requestUserIdFilter,
  }) async {
    emitState(
      followRequestsStatus: ProfilePageStateFollowRequestsStatus.loading,
    );

    final userRelationOrFailure =
        await userRelationUseCases.acceptFollowRequestViaApi(
      requestUserIdFilter: requestUserIdFilter,
    );

    userRelationOrFailure.fold(
      (error) => emitState(
        followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
        followRequestsError: ErrorWithTitleAndMessage(
          title: "Accept User Relation Failure",
          message: mapFailureToMessage(error),
        ),
      ),
      (user) {
        emitState(
          followRequests: List.from(state.followRequests ?? [])..remove(user),
          followRequestsStatus: ProfilePageStateFollowRequestsStatus.success,
          //   followers: List.from(state.followers ?? [])..add(user),
          followersStatus: ProfilePageStateFollowersStatus.success,
          user: UserEntity.merge(
            newEntity: UserEntity(
              id: state.user.id,
              authId: state.user.authId,
              userRelationCounts: UserRelationsCountEntity(
                followedCount: state.user.userRelationCounts != null &&
                        state.user.userRelationCounts!.followedCount != null
                    ? state.user.userRelationCounts!.followedCount! + 1
                    : 1,
              ),
            ),
            oldEntity: state.user,
          ),
        );
      },
    );
  }

  Future followOrUnfollowUserViaApi() async {
    emitState(
      followRequestsStatus: ProfilePageStateFollowRequestsStatus.loading,
      followedStatus: ProfilePageStateFollowedStatus.error,
    );

    final userRelationOrFailure =
        await userRelationUseCases.followOrUnfollowUserViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        requesterUserId: authCubit.state.currentUser.id,
        targetUserId: state.user.id,
      ),
      userRelationEntity: state.user.myUserRelationToOtherUser,
    );

    userRelationOrFailure.fold(
      (error) => emitState(
        status: ProfilePageStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Follow Or Unfollow Failure",
          message: mapFailureToMessage(error),
        ),
      ),
      (booleanOrUserRelation) {
        booleanOrUserRelation.fold(
          (userRelation) {
            emitState(
              user: UserEntity.merge(
                newEntity: UserEntity(
                  id: state.user.id,
                  authId: state.user.authId,
                  myUserRelationToOtherUser: userRelation,
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
              followedStatus: ProfilePageStateFollowedStatus.success,
              followed: List.from(state.followed ?? [])
                ..removeWhere(
                  (element) => element.id == authCubit.state.currentUser.id,
                ),
              user: UserEntity.merge(
                removeMyUserRelation: true,
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
    ProfilePageStateStatus? status,
    ErrorWithTitleAndMessage? error,
    List<UserEntity>? followers,
    ProfilePageStateFollowersStatus? followersStatus,
    ErrorWithTitleAndMessage? followersError,
    int? followersOffset,
    List<UserEntity>? followRequests,
    ProfilePageStateFollowRequestsStatus? followRequestsStatus,
    ErrorWithTitleAndMessage? followRequestsError,
    int? followRequestsOffset,
    List<UserEntity>? followed,
    ProfilePageStateFollowedStatus? followedStatus,
    ErrorWithTitleAndMessage? followedError,
    int? followedOffset,
  }) {
    emit(
      ProfilePageState(
        user: user ?? state.user,
        status: status ?? ProfilePageStateStatus.initial,
        error: error ?? state.error,
        followers: followers ?? state.followers,
        followersStatus:
            followersStatus ?? ProfilePageStateFollowersStatus.initial,
        followersError: followersError ?? state.followersError,
        followersOffset: followersOffset ?? state.followersOffset,
        followRequests: followRequests ?? state.followRequests,
        followRequestsStatus: followRequestsStatus ??
            ProfilePageStateFollowRequestsStatus.initial,
        followRequestsError: followRequestsError ?? state.followRequestsError,
        followRequestsOffset:
            followRequestsOffset ?? state.followRequestsOffset,
        followed: followed ?? state.followed,
        followedStatus:
            followedStatus ?? ProfilePageStateFollowedStatus.initial,
        followedError: followedError ?? state.followedError,
        followedOffset: followedOffset ?? state.followedOffset,
      ),
    );
  }
}
