import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';
part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  final UserUseCases userUseCases;
  final UserRelationUseCases userRelationUseCases;

  UserSearchCubit({
    required this.userUseCases,
    required this.userRelationUseCases,
    required this.authCubit,
    required this.notificationCubit,
  }) : super(UserSearchState(users: []));

  Future getUsersViaApi({
    bool loadMore = false,
    FindUsersFilter? findUsersFilter,
  }) async {
    emit(UserSearchState(
      status: loadMore
          ? UserSearchStateStatus.loadingMore
          : UserSearchStateStatus.loading,
      users: state.users,
    ));

    final Either<NotificationAlert, List<UserEntity>> userSearchOrFailure =
        await userUseCases.getUsersViaApi(
      findUsersFilter: findUsersFilter ?? FindUsersFilter(),
      limitOffsetFilter: LimitOffsetFilter(
        limit: 20,
        offset: loadMore ? state.users.length : 0,
      ),
    );

    userSearchOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(UserSearchState(
          users: state.users,
          status: UserSearchStateStatus.initial,
        ));
      },
      (users) => emit(
        UserSearchState(
          users: loadMore ? (List.from(state.users)..addAll(users)) : users,
          status: UserSearchStateStatus.success,
        ),
      ),
    );
  }

  Future getUsersByPermissionViaApi({
    bool loadMore = false,
    RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission,
    RequesterPrivateEventAddPermissionEnum? requesterPrivateEventAddPermission,
    RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission,
  }) async {
    emit(UserSearchState(
      status: loadMore
          ? UserSearchStateStatus.loadingMore
          : UserSearchStateStatus.loading,
      users: state.users,
    ));

    final Either<NotificationAlert, List<UserEntity>> userSearchOrFailure =
        await userRelationUseCases.getFollowedViaApi(
      findFollowedFilter: FindFollowedFilter(
        requesterUserId: authCubit.state.currentUser.id,
        requesterGroupchatAddPermission: requesterGroupchatAddPermission,
        requesterPrivateEventAddPermission: requesterPrivateEventAddPermission,
        requesterCalenderWatchPermission: requesterCalenderWatchPermission,
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: 20,
        offset: loadMore ? state.users.length : 0,
      ),
    );

    userSearchOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(UserSearchState(
          users: state.users,
          status: UserSearchStateStatus.initial,
        ));
      },
      (users) => emit(UserSearchState(
        users: loadMore ? (List.from(state.users)..addAll(users)) : users,
        status: UserSearchStateStatus.success,
      )),
    );
  }

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
            List<UserEntity> users = state.users;

            final foundIndex = users.indexWhere(
              (element) => element.id == user.id,
            );
            if (foundIndex != -1) {
              users[foundIndex] = UserEntity.merge(
                newEntity: UserEntity(
                  id: user.id,
                  authId: user.authId,
                  myUserRelationToOtherUser: userRelation,
                ),
                oldEntity: user,
              );
            }

            emit(UserSearchState(
              users: users,
              status: UserSearchStateStatus.success,
            ));
          },
          (boolean) {
            if (boolean == false) {
              notificationCubit.newAlert(
                notificationAlert: NotificationAlert(
                  title: "Follow or Unfollow Fehler",
                  message: "Fehler beim folgen oder entfolgen eines Users",
                ),
              );
              return;
            }
            List<UserEntity>? users = state.users;

            final foundIndex = users.indexWhere(
              (element) => element.id == user.id,
            );

            if (foundIndex != -1) {
              users[foundIndex] = UserEntity.merge(
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

            emit(UserSearchState(
              users: users,
              status: UserSearchStateStatus.success,
            ));
          },
        );
      },
    );
  }
}
