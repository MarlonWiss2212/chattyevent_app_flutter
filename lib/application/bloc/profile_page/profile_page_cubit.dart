import 'dart:async';
import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_followers_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  final UserRelationUseCases userRelationUseCases;
  final UserUseCases userUseCases;
  final MessageUseCases messageUseCases;

  StreamSubscription<Either<NotificationAlert, MessageEntity>>? _subscription;

  ProfilePageCubit(
    super.initialState, {
    required this.authCubit,
    required this.notificationCubit,
    required this.userRelationUseCases,
    required this.userUseCases,
    required this.messageUseCases,
  });

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }

  Future getCurrentUserViaApi() async {
    emitState(status: ProfilePageStateStatus.loading);
    final Either<NotificationAlert, UserEntity> userOrFailure =
        await userUseCases.getUserViaApi(
      currentUser: state.user.id == authCubit.state.currentUser.id ||
          state.user.authId == authCubit.state.currentUser.authId,
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
    emitState(followersStatus: ProfilePageStateFollowersStatus.loading);

    final Either<NotificationAlert, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowersViaApi(
      findFollowersFilter: FindFollowersFilter(targetUserId: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.followers.length > 20
                ? state.followers.length
                : 20
            : 20,
        offset: reload ? 0 : state.followers.length,
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
          followers: reload ? users : [...state.followers, ...users],
        );
      },
    );
  }

  Future getFollowRequests({
    bool reload = false,
  }) async {
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
        limit: reload
            ? state.followRequests.length > 20
                ? state.followRequests.length
                : 20
            : 20,
        offset: reload ? 0 : state.followRequests.length,
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
          followRequests: reload ? users : [...state.followRequests, ...users],
        );
      },
    );
  }

  Future getFollowed({
    bool reload = false,
  }) async {
    emitState(followedStatus: ProfilePageStateFollowedStatus.loading);

    final Either<NotificationAlert, List<UserEntity>> userOrFailure =
        await userRelationUseCases.getFollowedViaApi(
      findFollowedFilter: FindFollowedFilter(requesterUserId: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.followed.length > 20
                ? state.followed.length
                : 20
            : 20,
        offset: reload ? 0 : state.followed.length,
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
          followed: reload ? users : [...state.followed, ...users],
        );
      },
    );
  }

  /// this 3 can only be made if the profile user is the current user // replace later with auth cubit . listen
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
            //TODO:
            //userRelationCounts:,
          ),
          oldEntity: state.user,
        );
        emitState(
          followRequests: List.from(state.followRequests)
            ..removeWhere((user) => user.id == userId),
          user: user,
        );
        authCubit.emitState(currentUser: user);
      },
    );
  }

  Future deleteFollowerOrRequest({
    required String userId,
  }) async {
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
              message: "Fehler bein löschen einer User Relation",
            ),
          );
          return;
        }

        // when deleting profile user as my follower
        if (state.user.id == userId) {
          final newUser = UserEntity.merge(
            removeOtherUserRelationToMe: true,
            newEntity: UserEntity(
              id: state.user.id,
              authId: state.user.authId,
              //TODO:
              //   userRelationCounts:
            ),
            oldEntity: state.user,
          );
          emitState(user: newUser);
          authCubit.emitState(currentUser: newUser);
        }
        // when deleting my followers
        else {
          emitState(
            followers: List.from(state.followers)
              ..removeWhere(
                (user) => user.id == userId,
              ),
            followRequests: List.from(state.followRequests)
              ..removeWhere(
                (user) => user.id == userId,
              ),
          );
        }
      },
    );
  }

  /// this is then you try to change relation to the current profile user
  Future createUpdateUserOrDeleteCurrentProfileUserRelationViaApi({
    UserRelationStatusEnum? value,
  }) async {
    final userRelationOrFailure =
        await userRelationUseCases.createUpdateUserOrDeleteRelationViaApi(
      findOneUserRelationFilter: FindOneUserRelationFilter(
        requesterUserId: authCubit.state.currentUser.id,
        targetUserId: state.user.id,
      ),
      value: value,
      createUserRelation: state.user.myUserRelationToOtherUser == null,
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
                  // TODO rewrite this cause follower count only is relevant when user relation was follower but it could be anything
                  //userRelationCounts:
                ),
                oldEntity: state.user,
              ),
            );
          },
        );
      },
    );
  }

  /// this is when you to change relation to any user and not the current profile user
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
            List<UserEntity>? followed = state.followed;
            List<UserEntity>? followers = state.followers;

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

            final foundIndexFollowers = followers.indexWhere(
              (element) => element.id == user.id,
            );
            if (foundIndexFollowers != -1) {
              followers[foundIndexFollowers] = UserEntity.merge(
                newEntity: UserEntity(
                  id: user.id,
                  authId: user.authId,
                  myUserRelationToOtherUser: userRelation,
                ),
                oldEntity: user,
              );
            }
            emitState(
              followers: followers,
              followed: followed,
            );
          },
          (boolean) {
            if (boolean == false) return;
            List<UserEntity>? followed = state.followed;
            List<UserEntity>? followers = state.followers;

            final foundIndex = followed.indexWhere(
              (element) => element.id == user.id,
            );

            if (foundIndex != -1) {
              followed[foundIndex] = UserEntity.merge(
                removeMyUserRelation: true,
                newEntity: UserEntity(
                  id: followed[foundIndex].id,
                  authId: followed[foundIndex].authId,
                ),
                oldEntity: followed[foundIndex],
              );
            }
            final foundIndexFollowers = followers.indexWhere(
              (element) => element.id == user.id,
            );
            if (foundIndexFollowers != -1) {
              followers[foundIndexFollowers] = UserEntity.merge(
                removeMyUserRelation: true,
                newEntity: UserEntity(
                  id: followers[foundIndexFollowers].id,
                  authId: followers[foundIndexFollowers].authId,
                ),
                oldEntity: followers[foundIndexFollowers],
              );
            }
            emitState(
              followers: followers,
              followed: followed,
            );
          },
        );
      },
    );
  }

  // messages only if follow the other user
  void listenToMessages() {
    final eitherAlertOrStream = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(userTo: state.user.id),
    );

    eitherAlertOrStream.fold(
      (alert) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Nachrichten error",
          message:
              "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
        ),
      ),
      (subscription) {
        _subscription = subscription.listen(
          (event) {
            event.fold(
              (error) => notificationCubit.newAlert(
                notificationAlert: NotificationAlert(
                  title: "Nachrichten error",
                  message:
                      "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
                ),
              ),
              (message) => addMessage(message: message),
            );
          },
        );
      },
    );
  }

  Future loadMessages({bool reload = false}) async {
    emitState(loadingMessages: true);

    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      findMessagesFilter: FindMessagesFilter(userTo: state.user.id),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.messages.length > 20
                ? state.messages.length
                : 20
            : 20,
        offset: reload ? 0 : state.messages.length,
      ),
    );

    messagesOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingMessages: false);
      },
      (messages) {
        List<MessageEntity> newMessages = [];
        if (reload == false) {
          newMessages = [...state.messages, ...messages];
        } else {
          newMessages = messages;
        }

        emitState(messages: newMessages, loadingMessages: false);
      },
    );
  }

  MessageEntity addMessage({required MessageEntity message}) {
    emitState(messages: List.from(state.messages)..add(message));
    return message;
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
    List<MessageEntity>? messages,
    bool? loadingMessages,
  }) {
    final List<MessageEntity> allMessages = messages ?? state.messages;
    allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(
      ProfilePageState(
        messages: allMessages,
        loadingMessages: loadingMessages ?? state.loadingMessages,
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
