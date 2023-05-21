import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:dartz/dartz.dart';
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
      (alert) {
        if (state.user.id == authCubit.state.currentUser.id) {
          authCubit.emitState(userException: alert.exception);
        }
        emitState(status: ProfilePageStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
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
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(followersStatus: ProfilePageStateFollowersStatus.initial);
      },
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
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(
            followRequestsStatus: ProfilePageStateFollowRequestsStatus.initial);
      },
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
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(followedStatus: ProfilePageStateFollowedStatus.initial);
      },
      (users) {
        emitState(
          followedStatus: ProfilePageStateFollowedStatus.success,
          followed: reload ? users : List.from(state.followed ?? [])
            ..addAll(users),
        );
      },
    );
  }

  /// this four can only be made if the profile user is the current user // replace later with auth cubit . listen
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
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        authCubit.emitState(userException: alert.exception);
      },
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

  Future acceptFollowRequest({required String userId}) async {
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

    final userRelationOrFailure = await userRelationUseCases
        .acceptFollowRequestViaApi(requesterUserId: userId);

    userRelationOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (userRelation) {
        final user = UserEntity.merge(
          newEntity: UserEntity(
            id: state.user.id,
            authId: state.user.authId,
            userRelationCounts: UserRelationsCountEntity(
              followerCount: state.user.userRelationCounts != null &&
                      state.user.userRelationCounts!.followerCount != null
                  ? state.user.userRelationCounts!.followerCount! + 1
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
          title: "Delete User Relation Request Fehler",
          message:
              "Du kannst keine Freundschaftsanfragen von anderen Profilen ablehnen",
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

  Future deleteFollower({
    required String userId,
  }) async {
    if (state.user.id != authCubit.state.currentUser.id &&
        state.user.id != userId) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Delete Follower",
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
              title: "Delete Follower",
              message: "Fehler bein löschen eines Followers",
            ),
          );
          return;
        }

        // when deleting profile user as my follower
        if (state.user.id == userId) {
          emitState(
            user: UserEntity.merge(
              removeOtherUserRelationToMe: true,
              newEntity: UserEntity(
                id: state.user.id,
                authId: state.user.authId,
                userRelationCounts: UserRelationsCountEntity(
                  followedCount: state.user.userRelationCounts != null &&
                          state.user.userRelationCounts!.followedCount != null
                      ? state.user.userRelationCounts!.followedCount! - 1
                      : null,
                ),
              ),
              oldEntity: state.user,
            ),
          );
          // make count less for deleting follower
          authCubit.emitState(
            currentUser: UserEntity.merge(
              newEntity: UserEntity(
                id: authCubit.state.currentUser.id,
                authId: authCubit.state.currentUser.authId,
                userRelationCounts: UserRelationsCountEntity(
                  followerCount: state.user.userRelationCounts != null &&
                          state.user.userRelationCounts!.followerCount != null
                      ? state.user.userRelationCounts!.followerCount! - 1
                      : null,
                ),
              ),
              oldEntity: authCubit.state.currentUser,
            ),
          );
        }
        // when deleting my followers
        else {
          final user = UserEntity.merge(
            newEntity: UserEntity(
              id: state.user.id,
              authId: state.user.authId,
              userRelationCounts: UserRelationsCountEntity(
                followerCount: state.user.userRelationCounts != null &&
                        state.user.userRelationCounts!.followerCount != null
                    ? state.user.userRelationCounts!.followerCount! - 1
                    : null,
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
        }
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
                        : null,
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
                    id: followed[foundIndex].id,
                    authId: followed[foundIndex].authId,
                    userRelationCounts: UserRelationsCountEntity(
                      followerCount:
                          followed[foundIndex].userRelationCounts != null &&
                                  followed[foundIndex]
                                          .userRelationCounts!
                                          .followerCount !=
                                      null &&
                                  followed[foundIndex]
                                          .userRelationCounts!
                                          .followerCount! >
                                      0
                              ? user.userRelationCounts!.followerCount! - 1
                              : null,
                    ),
                  ),
                  oldEntity: followed[foundIndex],
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
                    id: followers[foundIndex].id,
                    authId: followers[foundIndex].authId,
                    userRelationCounts: UserRelationsCountEntity(
                      followerCount:
                          followers[foundIndex].userRelationCounts != null &&
                                  followers[foundIndex]
                                          .userRelationCounts!
                                          .followerCount !=
                                      null &&
                                  followers[foundIndex]
                                          .userRelationCounts!
                                          .followerCount! >
                                      0
                              ? user.userRelationCounts!.followerCount! - 1
                              : null,
                    ),
                  ),
                  oldEntity: followers[foundIndex],
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
            UserRelationStatusEnum.follower) {
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
            UserRelationStatusEnum.follower) {
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
        status: status ?? state.status,
        followers: followers ?? state.followers,
        followersStatus: followersStatus ?? state.followersStatus,
        followRequests: followRequests ?? state.followRequests,
        followRequestsStatus:
            followRequestsStatus ?? state.followRequestsStatus,
        followed: followed ?? state.followed,
        followedStatus: followedStatus ?? state.followedStatus,
      ),
    );
  }
}
