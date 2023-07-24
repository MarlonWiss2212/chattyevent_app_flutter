import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_followers_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_one_user_relation_filter.dart';
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
          users: loadMore ? [...state.users, ...users] : users,
          status: UserSearchStateStatus.success,
        ),
      ),
    );
  }

  /// to see if you have the permission to add others
  Future getFollowedViaApi({
    bool loadMore = false,
    bool? filterForPrivateEventAddMeAllowedUsers,
    bool? filterForGroupchatAddMeAllowedUsers,
    String? search,
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
        filterForPrivateEventAddMeAllowedUsers:
            filterForPrivateEventAddMeAllowedUsers,
        filterForGroupchatAddMeAllowedUsers:
            filterForGroupchatAddMeAllowedUsers,
        search: search,
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
        users: loadMore ? [...state.users, ...users] : users,
        status: UserSearchStateStatus.success,
      )),
    );
  }

  Future getFollowersViaApi({
    bool loadMore = false,
    bool? filterForPrivateEventAddMeAllowedUsers,
    bool? sortForPrivateEventAddMeAllowedUsersFirst,
    bool? sortForGroupchatAddMeAllowedUsersFirst,
    bool? filterForGroupchatAddMeAllowedUsers,
    String? search,
  }) async {
    emit(UserSearchState(
      status: loadMore
          ? UserSearchStateStatus.loadingMore
          : UserSearchStateStatus.loading,
      users: state.users,
    ));

    final Either<NotificationAlert, List<UserEntity>> userSearchOrFailure =
        await userRelationUseCases.getFollowersViaApi(
      findFollowersFilter: FindFollowersFilter(
        targetUserId: authCubit.state.currentUser.id,
        filterForGroupchatAddMeAllowedUsers:
            filterForGroupchatAddMeAllowedUsers,
        filterForPrivateEventAddMeAllowedUsers:
            filterForPrivateEventAddMeAllowedUsers,
        sortForGroupchatAddMeAllowedUsersFirst:
            sortForGroupchatAddMeAllowedUsersFirst,
        sortForPrivateEventAddMeAllowedUsersFirst:
            sortForPrivateEventAddMeAllowedUsersFirst,
        search: search,
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
        users: loadMore ? [...state.users, ...users] : users,
        status: UserSearchStateStatus.success,
      )),
    );
  }

  Future createUpdateUserOrDeleteRelationViaApi({
    required UserEntity user,
    UserRelationStatusEnum? value,
  }) async {
    final userRelationOrFailure =
        await userRelationUseCases.createUpdateUserOrDeleteRelationViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        requesterUserId: authCubit.state.currentUser.id,
        targetUserId: user.id,
      ),
      value: value,
      createUserRelation: user.myUserRelationToOtherUser == null,
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
                  id: users[foundIndex].id,
                  authId: users[foundIndex].authId,
                  myUserRelationToOtherUser: userRelation,
                ),
                oldEntity: users[foundIndex],
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
                  id: users[foundIndex].id,
                  authId: users[foundIndex].authId,
                  //TODO: count isnt right check if it was a follower before changing count
                  //userRelationCounts:,
                ),
                oldEntity: users[foundIndex],
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
