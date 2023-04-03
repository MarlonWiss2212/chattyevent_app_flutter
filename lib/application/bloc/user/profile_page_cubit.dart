import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/update_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
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
        authId: state.user.authId != "" &&
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
        final replacedUser = userCubit.replaceOrAdd(user: user);
        if (state.user.id == authCubit.state.currentUser.id) {
          authCubit.emitState(currentUser: replacedUser);
        }
        emitState(status: ProfilePageStateStatus.success, user: replacedUser);
      },
    );
  }

  Future getFollowers({
    bool reload = false,
  }) async {
    const int limit = 30;

    emitState(followersStatus: ProfilePageStateFollowersStatus.loading);

    final Either<Failure, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowersViaApi(
      targetUserIdFilter: TargetUserIdFilter(targetUserId: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload ? state.followers?.length ?? limit : limit,
        offset: reload ? 0 : state.followers?.length ?? 0,
      ),
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
          followersStatus: ProfilePageStateFollowersStatus.success,
          followers: List.from(state.followers ?? [])..addAll(users),
        );
      },
    );
  }

  Future getFollowRequests({
    bool reload = false,
  }) async {
    const int limit = 30;

    if (authCubit.state.currentUser.id != state.user.id) {
      emitState(
        followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
        followRequestsError: ErrorWithTitleAndMessage(
          title: "Get Follow Request Fehler",
          message: "Du kannst nicht die Freundschaftsanfragen anderer sehen",
        ),
      );
      return;
    }

    emitState(
      followRequestsStatus: ProfilePageStateFollowRequestsStatus.loading,
    );

    final Either<Failure, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowerRequestsViaApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload ? state.followers?.length ?? limit : limit,
        offset: reload ? 0 : state.followers?.length ?? 0,
      ),
    );

    userOrFailure.fold(
      (error) {
        emitState(
          followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
          followRequestsError: ErrorWithTitleAndMessage(
            title: "Get Follow Request Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (users) {
        emitState(
          followRequestsStatus: ProfilePageStateFollowRequestsStatus.success,
          followRequests: List.from(state.followRequests ?? [])..addAll(users),
        );
      },
    );
  }

  Future getFollowed({
    bool reload = false,
  }) async {
    const int limit = 30;

    emitState(followedStatus: ProfilePageStateFollowedStatus.loading);

    final Either<Failure, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowedViaApi(
      requestUserIdFilter: RequestUserIdFilter(requesterUserId: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload ? state.followers?.length ?? limit : limit,
        offset: reload ? 0 : state.followers?.length ?? 0,
      ),
    );

    userOrFailure.fold(
      (error) {
        emitState(
          followedStatus: ProfilePageStateFollowedStatus.error,
          followedError: ErrorWithTitleAndMessage(
            title: "Get User Relation Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (users) {
        emitState(
          followedStatus: ProfilePageStateFollowedStatus.success,
          followed: List.from(state.followed ?? [])..addAll(users),
        );
      },
    );
  }

  /// this three can only be made if the profile user is the current user

  Future updateUser({
    required UpdateUserDto updateUserDto,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id) {
      emitState(
        followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
        followRequestsError: ErrorWithTitleAndMessage(
          title: "Update User Fehler",
          message: "Du kannst andere User nicht ändern",
        ),
      );
      return;
    }

    final userOrFailure = await userUseCases.updateUserViaApi(
      updateUserDto: updateUserDto,
    );

    userOrFailure.fold(
      (error) => emitState(
        status: ProfilePageStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Update User Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (user) {
        final newUser = UserEntity.merge(
          newEntity: user,
          oldEntity: state.user,
        );
        emitState(user: newUser);
        authCubit.emitState(currentUser: newUser);
      },
    );
  }

  Future acceptFollowRequest({
    required String userId,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id) {
      emitState(
        followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
        followRequestsError: ErrorWithTitleAndMessage(
          title: "Accept User Relation Failure",
          message:
              "Du kannst keine Freundschaftsanfragen auf anderen Profilen annehmen",
        ),
      );
      return;
    }
    emitState(
      followRequestsStatus: ProfilePageStateFollowRequestsStatus.loading,
    );

    final userRelationOrFailure =
        await userRelationUseCases.acceptFollowRequestViaApi(
      requestUserIdFilter: RequestUserIdFilter(requesterUserId: userId),
    );

    userRelationOrFailure.fold(
      (error) => emitState(
        followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
        followRequestsError: ErrorWithTitleAndMessage(
          title: "Accept User Relation Failure",
          message: mapFailureToMessage(error),
        ),
      ),
      (userRelation) {
        final user = UserEntity.merge(
          newEntity: UserEntity(
            id: state.user.id,
            authId: state.user.authId,
            userRelationCounts: UserRelationsCountEntity(
              followerCount: state.user.userRelationCounts != null &&
                      state.user.userRelationCounts!.followedCount != null
                  ? state.user.userRelationCounts!.followedCount! + 1
                  : 1,
            ),
          ),
          oldEntity: state.user,
        );
        emitState(
          followRequests: List.from(state.followRequests ?? [])
            ..removeWhere((user) => user.id == userId),
          user: user,
        );
        authCubit.emitState(currentUser: user);
      },
    );
  }

  Future deleteFollowRequest({
    required String userId,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id) {
      emitState(
        followRequestsStatus: ProfilePageStateFollowRequestsStatus.error,
        followRequestsError: ErrorWithTitleAndMessage(
          title: "Accept User Relation Failure",
          message:
              "Du kannst keine Freundschaftsanfragen auf anderen Profilen ablehnen",
        ),
      );
      return;
    }
    final userRelationOrFailure =
        await userRelationUseCases.deleteUserRelationViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        targetUserId: state.user.id,
        requesterUserId: userId,
      ),
    );

    userRelationOrFailure.fold(
      (error) => emitState(
        status: ProfilePageStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Delete User Relation Failure",
          message: mapFailureToMessage(error),
        ),
      ),
      (boolean) {
        if (boolean == false) {
          emitState(
            status: ProfilePageStateStatus.error,
            error: ErrorWithTitleAndMessage(
              title: "Delete User Relation Failure",
              message: "Fehler beim löschen der Relation",
            ),
          );
          return;
        }
        final user = UserEntity.merge(
          newEntity: UserEntity(
            id: state.user.id,
            authId: state.user.authId,
            userRelationCounts: UserRelationsCountEntity(
              followRequestCount: state.user.userRelationCounts != null &&
                      state.user.userRelationCounts!.followedCount != null
                  ? state.user.userRelationCounts!.followedCount! - 1
                  : 0,
            ),
          ),
          oldEntity: state.user,
        );
        emitState(
          followRequests: List.from(state.followRequests ?? [])
            ..removeWhere((user) => user.id == userId),
          user: user,
        );
        authCubit.emitState(currentUser: user);
      },
    );
  }

  Future deleteFollower({
    required String userId,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id) {
      emitState(
        followersStatus: ProfilePageStateFollowersStatus.error,
        followersError: ErrorWithTitleAndMessage(
          title: "Accept User Relation Failure",
          message: "Du kannst keinen Follower eines anderen Profiles löschen",
        ),
      );
      return;
    }

    final userRelationOrFailure =
        await userRelationUseCases.deleteUserRelationViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        targetUserId: authCubit.state.currentUser.id,
        requesterUserId: userId,
      ),
    );

    userRelationOrFailure.fold(
      (error) => emitState(
        followersStatus: ProfilePageStateFollowersStatus.error,
        followersError: ErrorWithTitleAndMessage(
          title: "Delete User Relation Failure",
          message: mapFailureToMessage(error),
        ),
      ),
      (boolean) {
        if (boolean == false) {
          emitState(
            followersStatus: ProfilePageStateFollowersStatus.error,
            followersError: ErrorWithTitleAndMessage(
              title: "Delete User Relation Failure",
              message: "Fehler beim löschen der Relation",
            ),
          );
          return;
        }
        final user = UserEntity.merge(
          newEntity: UserEntity(
            id: state.user.id,
            authId: state.user.authId,
            userRelationCounts: UserRelationsCountEntity(
              followerCount: state.user.userRelationCounts != null &&
                      state.user.userRelationCounts!.followedCount != null
                  ? state.user.userRelationCounts!.followedCount! - 1
                  : 0,
            ),
          ),
          oldEntity: state.user,
        );
        emitState(
          followers: List.from(state.followRequests ?? [])
            ..removeWhere(
              (user) => user.id == userId,
            ),
          user: user,
        );
        authCubit.emitState(currentUser: user);
      },
    );
  }

  /// this is then you try to follow or unfollow the current profile user
  Future followOrUnfollowCurrentProfileUserViaApi() async {
    final userRelationOrFailure =
        await userRelationUseCases.followOrUnfollowUserViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        requesterUserId: authCubit.state.currentUser.id,
        targetUserId: state.user.id,
      ),
      myUserRelationToOtherUser: state.user.myUserRelationToOtherUser,
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

  /// this is when you try to follow any user and not the current profile user
  Future followOrUnfollowUserViaApi({required UserEntity user}) async {
    final userRelationOrFailure =
        await userRelationUseCases.followOrUnfollowUserViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        requesterUserId: authCubit.state.currentUser.id,
        targetUserId: user.id,
      ),
      myUserRelationToOtherUser: user.myUserRelationToOtherUser,
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
            List<UserEntity>? followed = state.followed;
            List<UserEntity>? followers = state.followers;

            if (followed != null) {
              final foundIndex = followed.indexWhere(
                (element) => element.id == user.id,
              );
              if (foundIndex != -1) {
                followed[foundIndex] = UserEntity.merge(
                  newEntity: UserEntity(
                    id: user.id,
                    authId: user.authId,
                    myUserRelationToOtherUser: userRelation,
                  ),
                  oldEntity: user,
                );
              }
            }
            if (followers != null) {
              final foundIndex = followers.indexWhere(
                (element) => element.id == user.id,
              );
              if (foundIndex != -1) {
                followers[foundIndex] = UserEntity.merge(
                  newEntity: UserEntity(
                    id: user.id,
                    authId: user.authId,
                    myUserRelationToOtherUser: userRelation,
                  ),
                  oldEntity: user,
                );
              }
            }
            emitState(followers: followers, followed: followed);
          },
          (boolean) {
            if (boolean == false) {
              return;
            }
            List<UserEntity>? followed = state.followed;
            List<UserEntity>? followers = state.followers;

            if (followed != null) {
              final foundIndex = followed.indexWhere(
                (element) => element.id == user.id,
              );

              if (foundIndex != -1) {
                followed[foundIndex] = UserEntity.merge(
                  removeMyUserRelation: true,
                  newEntity: UserEntity(
                    id: user.id,
                    authId: user.authId,
                    userRelationCounts: UserRelationsCountEntity(
                      followerCount: user.userRelationCounts != null &&
                              user.userRelationCounts!.followerCount != null &&
                              user.userRelationCounts!.followerCount! > 0
                          ? user.userRelationCounts!.followerCount! - 1
                          : 0,
                    ),
                  ),
                  oldEntity: user,
                );
              }
            }
            if (followers != null) {
              final foundIndex = followers.indexWhere(
                (element) => element.id == user.id,
              );
              if (foundIndex != -1) {
                followers[foundIndex] = UserEntity.merge(
                  removeMyUserRelation: true,
                  newEntity: UserEntity(
                    id: user.id,
                    authId: user.authId,
                    userRelationCounts: UserRelationsCountEntity(
                      followerCount: user.userRelationCounts != null &&
                              user.userRelationCounts!.followerCount != null &&
                              user.userRelationCounts!.followerCount! > 0
                          ? user.userRelationCounts!.followerCount! - 1
                          : 0,
                    ),
                  ),
                  oldEntity: user,
                );
              }
            }

            emitState(followed: followed, followers: followers);
          },
        );
      },
    );
  }

  ///

  emitState({
    UserEntity? user,
    ProfilePageStateStatus? status,
    ErrorWithTitleAndMessage? error,
    List<UserEntity>? followers,
    ProfilePageStateFollowersStatus? followersStatus,
    ErrorWithTitleAndMessage? followersError,
    List<UserEntity>? followRequests,
    ProfilePageStateFollowRequestsStatus? followRequestsStatus,
    ErrorWithTitleAndMessage? followRequestsError,
    List<UserEntity>? followed,
    ProfilePageStateFollowedStatus? followedStatus,
    ErrorWithTitleAndMessage? followedError,
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
        followRequests: followRequests ?? state.followRequests,
        followRequestsStatus: followRequestsStatus ??
            ProfilePageStateFollowRequestsStatus.initial,
        followRequestsError: followRequestsError ?? state.followRequestsError,
        followed: followed ?? state.followed,
        followedStatus:
            followedStatus ?? ProfilePageStateFollowedStatus.initial,
        followedError: followedError ?? state.followedError,
      ),
    );
  }
}
