import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user_relation/update_user_relation_follow_data_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_followers_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  final UserRelationUseCases userRelationUseCases;
  final UserUseCases userUseCases;

  ProfilePageCubit(
    super.initialState, {
    required this.authCubit,
    required this.notificationCubit,
    required this.userRelationUseCases,
    required this.userUseCases,
  });

  Future getCurrentUserViaApi() async {
    emitState(status: ProfilePageStateStatus.loading);
    final Either<NotificationAlert, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      findOneUserFilter: FindOneUserFilter(
        id: state.user.id != "" ? state.user.id : null,
        authId: state.user.authId != "" &&
                state.user.authId == authCubit.state.currentUser.authId
            ? authCubit.state.currentUser.authId
            : null,
      ),
    );

    userOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (user) {
        if (state.user.id == authCubit.state.currentUser.id) {
          authCubit.emitState(currentUser: user);
        }
        emitState(status: ProfilePageStateStatus.success, user: user);
      },
    );
  }

  Future getFollowers({
    bool reload = false,
  }) async {
    const int limit = 30;

    emitState(followersStatus: ProfilePageStateFollowersStatus.loading);

    final Either<NotificationAlert, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowersViaApi(
      findFollowersFilter: FindFollowersFilter(targetUserId: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload ? state.followers?.length ?? limit : limit,
        offset: reload ? 0 : state.followers?.length ?? 0,
      ),
    );

    userOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (users) {
        emitState(
          followersStatus: ProfilePageStateFollowersStatus.success,
          followers: reload ? users : List.from(state.followers ?? [])
            ..addAll(users),
        );
      },
    );
  }

  Future getFollowRequests({
    bool reload = false,
  }) async {
    const int limit = 30;

    if (authCubit.state.currentUser.id != state.user.id) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Get Follow Request Fehler",
          message: "Du kannst nicht die Freundschaftsanfragen anderer sehen",
        ),
      );
      return;
    }

    emitState(
      followRequestsStatus: ProfilePageStateFollowRequestsStatus.loading,
    );

    final Either<NotificationAlert, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowerRequestsViaApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload ? state.followRequests?.length ?? limit : limit,
        offset: reload ? 0 : state.followRequests?.length ?? 0,
      ),
    );

    userOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (users) {
        emitState(
          followRequestsStatus: ProfilePageStateFollowRequestsStatus.success,
          followRequests: reload ? users : List.from(state.followRequests ?? [])
            ..addAll(users),
        );
      },
    );
  }

  Future getFollowed({
    bool reload = false,
  }) async {
    const int limit = 30;

    emitState(followedStatus: ProfilePageStateFollowedStatus.loading);

    final Either<NotificationAlert, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowedViaApi(
      findFollowedFilter: FindFollowedFilter(requesterUserId: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload ? state.followed?.length ?? limit : limit,
        offset: reload ? 0 : state.followed?.length ?? 0,
      ),
    );

    userOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (users) {
        emitState(
          followedStatus: ProfilePageStateFollowedStatus.success,
          followed: reload ? users : List.from(state.followed ?? [])
            ..addAll(users),
        );
      },
    );
  }

  /// this four can only be made if the profile user is the current user
  Future updateUser({
    required UpdateUserDto updateUserDto,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Accept User Relation Fehler",
          message:
              "Du kannst keine Freundschaftsanfragen auf anderen Profilen annehmen",
        ),
      );
      return;
    }
    emitState(
      followRequestsStatus: ProfilePageStateFollowRequestsStatus.loading,
    );

    final userRelationOrFailure = await userRelationUseCases
        .acceptFollowRequestViaApi(requesterUserId: userId);

    userRelationOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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
              followRequestCount: state.user.userRelationCounts != null &&
                      state.user.userRelationCounts!.followRequestCount != null
                  ? state.user.userRelationCounts!.followRequestCount! - 1
                  : null,
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
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Accept User Relation Fehler",
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (boolean) {
        if (boolean == false) {
          notificationCubit.newAlert(
            notificationAlert: NotificationAlert(
              title: "Delete User Relation Fehler",
              message: "Fehler beim Löschen der Relation",
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
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Delete Follower NotificationAlert",
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (boolean) {
        if (boolean == false) {
          notificationCubit.newAlert(
            notificationAlert: NotificationAlert(
              title: "Delete Follower NotificationAlert",
              message: "Fehler bein löschen eines Followers",
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

  //
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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

  // this is when you wanna update the permissions for the current profile user who follows you
  Future updateFollowDataCurrentProfileUserViaApi({
    required UpdateUserRelationFollowDataDto updateUserRelationFollowDataDto,
  }) async {
    if (state.user.otherUserRelationToMyUser == null ||
        state.user.otherUserRelationToMyUser!.statusOnRelatedUser !=
            "FOLLOWER") {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler Update Berechtigungen",
          message:
              "Du kannst nicht die Berechtigungen eines users ändern der dir nicht folgt",
        ),
      );
      return;
    }

    final userRelationOrFailure = await userRelationUseCases.updateFollowData(
      updateUserRelationFollowDataDto: updateUserRelationFollowDataDto,
      requesterUserId: state.user.id,
    );

    userRelationOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (userRelation) {
        emitState(
          user: UserEntity.merge(
            newEntity: UserEntity(
              id: state.user.id,
              authId: state.user.authId,
              otherUserRelationToMyUser: userRelation,
            ),
            oldEntity: state.user,
          ),
        );
      },
    );
  }

  // this is when you wanna update the permissions for any user but the profile user must be the current user
  Future updateFollowDataForFollowerViaApi({
    required int followerIndex,
    required UpdateUserRelationFollowDataDto updateUserRelationFollowDataDto,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler Update Berechtigungen",
          message:
              "Du kannst nicht die Berechtigungen eines users ändern der dir nicht folgt",
        ),
      );
      return;
    }
    if (state.followers == null ||
        state.followers![followerIndex].otherUserRelationToMyUser == null ||
        state.followers![followerIndex].otherUserRelationToMyUser!
                .statusOnRelatedUser !=
            "FOLLOWER") {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler Update Berechtigungen",
          message:
              "Du kannst nicht die Berechtigungen eines users ändern der dir nicht folgt",
        ),
      );
      return;
    }

    final userRelationOrFailure = await userRelationUseCases.updateFollowData(
      updateUserRelationFollowDataDto: updateUserRelationFollowDataDto,
      requesterUserId: state.followers![followerIndex].id,
    );

    userRelationOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (userRelation) {
        final List<UserEntity> followers = state.followers!;
        followers[followerIndex] = UserEntity.merge(
          newEntity: UserEntity(
            id: state.followers![followerIndex].id,
            authId: state.followers![followerIndex].authId,
            otherUserRelationToMyUser: userRelation,
          ),
          oldEntity: state.followers![followerIndex],
        );
        emitState(followers: followers);
      },
    );
  }

  emitState({
    UserEntity? user,
    ProfilePageStateStatus? status,
    List<UserEntity>? followers,
    ProfilePageStateFollowersStatus? followersStatus,
    List<UserEntity>? followRequests,
    ProfilePageStateFollowRequestsStatus? followRequestsStatus,
    List<UserEntity>? followed,
    ProfilePageStateFollowedStatus? followedStatus,
  }) {
    emit(
      ProfilePageState(
        user: user ?? state.user,
        status: status ?? ProfilePageStateStatus.initial,
        followers: followers ?? state.followers,
        followersStatus:
            followersStatus ?? ProfilePageStateFollowersStatus.initial,
        followRequests: followRequests ?? state.followRequests,
        followRequestsStatus: followRequestsStatus ??
            ProfilePageStateFollowRequestsStatus.initial,
        followed: followed ?? state.followed,
        followedStatus:
            followedStatus ?? ProfilePageStateFollowedStatus.initial,
      ),
    );
  }
}
