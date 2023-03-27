import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  final UserUseCases userUseCases;
  final AuthCubit authCubit;
  final UserRelationUseCases userRelationUseCases;

  UserSearchCubit({
    required this.userUseCases,
    required this.userRelationUseCases,
    required this.authCubit,
  }) : super(UserSearchState(users: []));

  Future getUsersViaApi({
    LimitOffsetFilter? limitOffsetFilter,
    GetUsersFilter? getUsersFilter,
  }) async {
    emit(UserSearchState(
      status: UserSearchStateStatus.loading,
      users: state.users,
    ));

    final Either<Failure, List<UserEntity>> userSearchOrFailure =
        await userUseCases.getUsersViaApi(
      getUsersFilter: getUsersFilter ?? GetUsersFilter(),
      limitOffsetFilter: limitOffsetFilter ??
          LimitOffsetFilter(
            limit: 10,
            offset: 0,
          ),
    );

    userSearchOrFailure.fold(
      (error) => emit(
        UserSearchState(
          users: state.users,
          status: UserSearchStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Get Users Fehler",
            message: mapFailureToMessage(error),
          ),
        ),
      ),
      (users) => emit(
        UserSearchState(users: users),
      ),
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
      (error) => UserSearchState(
        users: state.users,
        status: UserSearchStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Follow Or Unfollow Failure",
          message: mapFailureToMessage(error),
        ),
      ),
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
