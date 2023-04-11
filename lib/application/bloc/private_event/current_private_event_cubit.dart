import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/get_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/core/response/get-all-private-events-users-and-left-users.reponse.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/left_user_with_private_event_user_date.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final ChatCubit chatCubit;
  final AuthCubit authCubit;
  final UserCubit userCubit;
  final NotificationCubit notificationCubit;

  final PrivateEventUseCases privateEventUseCases;
  final ChatUseCases chatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.authCubit,
    required this.userCubit,
    required this.locationUseCases,
    required this.privateEventCubit,
    required this.chatCubit,
    required this.chatUseCases,
    required this.shoppingListItemUseCases,
    required this.privateEventUseCases,
  });

  // optimize this later
  Future getPrivateEventUsersAndLeftUsersViaApi() async {
    final response = await Future.wait([
      userCubit.getUsersViaApi(),
      privateEventUseCases.getPrivateEventUsersAndLeftUsers(
        privateEventId: state.privateEvent.id,
      ),
    ]);
    final Either<Failure, GetAllPrivateEventUsersAndLeftUsers> usersOrFailure =
        response[1];

    usersOrFailure.fold(
      (error) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Get Event User Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (usersAndLeftUsers) {
        setPrivateEventUsers(
          eitherLeftUsers: Right(usersAndLeftUsers.privateEventLeftUsers),
          eitherUsers: Right(usersAndLeftUsers.privateEventUsers),
        );
      },
    );
  }

  Future getPrivateEventAndGroupchatFromApi() async {
    await Future.wait([
      getCurrentPrivateEvent(),
      getCurrentChatViaApi(),
    ]);
  }

  void setPrivateEventUsers({
    required Either<List<UserWithPrivateEventUserData>,
            List<PrivateEventUserEntity>>
        eitherUsers,
    required Either<List<LeftUserWithPrivateEventUserData>,
            List<PrivateEventLeftUserEntity>>
        eitherLeftUsers,
  }) {
    List<UserWithPrivateEventUserData> usersToEmit = [];
    List<LeftUserWithPrivateEventUserData> leftUsersToEmit = [];

    eitherUsers.fold(
      (users) => usersToEmit = users,
      (privateEventUsers) {
        for (final privateEventUser in privateEventUsers) {
          final foundUser = userCubit.state.users.firstWhere(
            (element) => element.id == privateEventUser.userId,
            orElse: () => UserEntity(
              id: privateEventUser.userId ?? "",
              authId: "",
            ),
          );
          GroupchatUserEntity? foundGroupchatUser;
          if (state.chatState != null) {
            foundGroupchatUser = state.chatState!.currentChat.users?.firstWhere(
              (element) => element.userId == privateEventUser.userId,
              orElse: () => GroupchatUserEntity(id: ""),
            );
          }

          final newUser = UserWithPrivateEventUserData(
            user: foundUser,
            groupchatUser: foundGroupchatUser,
            privateEventUser: privateEventUser,
          );

          final foundIndex = usersToEmit.indexWhere(
            (element) => element.privateEventUser.id == privateEventUser.id,
          );

          foundIndex != -1
              ? usersToEmit[foundIndex] = newUser
              : usersToEmit.add(newUser);
        }
      },
    );

    eitherLeftUsers.fold(
      (leftUsers) => leftUsersToEmit = leftUsers,
      (privateEventLeftUsers) {
        for (final privateEventLeftUser in privateEventLeftUsers) {
          final foundUser = userCubit.state.users.firstWhere(
            (element) => element.id == privateEventLeftUser.userId,
            orElse: () => UserEntity(
              id: privateEventLeftUser.userId ?? "",
              authId: "",
            ),
          );

          final newLeftUser = LeftUserWithPrivateEventUserData(
            user: foundUser,
            privateEventLeftUser: privateEventLeftUser,
          );

          final foundIndex = leftUsersToEmit.indexWhere(
            (element) =>
                element.privateEventLeftUser.id == privateEventLeftUser.id,
          );

          foundIndex != -1
              ? leftUsersToEmit[foundIndex] = newLeftUser
              : leftUsersToEmit.add(newLeftUser);
        }
      },
    );

    emitState(
      privateEventUsers: usersToEmit,
      privateEventLeftUsers: leftUsersToEmit,
      currentUserIndex: usersToEmit.indexWhere(
        (element) => element.user.authId == authCubit.state.currentUser.authId,
      ),
    );
  }

  void setCurrentChatFromChatCubit() {
    emitState(
      chatState: chatCubit.state.chatStates.firstWhereOrNull(
        (element) => element.currentChat.id == state.privateEvent.groupchatTo,
      ),
    );
  }

  void setPrivateEventFromPrivateEventCubit() {
    emitState(
      privateEvent: privateEventCubit.state.privateEvents.firstWhereOrNull(
        (element) => element.id == state.privateEvent.id,
      ),
    );
  }

  Future getCurrentChatViaApi() async {
    if (state.privateEvent.groupchatTo == null) {
      return;
    }
    emitState(loadingGroupchat: true);

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(
        id: state.privateEvent.groupchatTo!,
      ),
    );

    await groupchatOrFailure.fold(
      (error) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "Get Groupchat Fehler",
            message: mapFailureToMessage(error),
          ),
        );
        emitState(loadingGroupchat: false);
      },
      (groupchat) async {
        final replacedChat = chatCubit.replaceOrAdd(
          chatState: CurrentChatState(
            currentUserIndex: -1,
            currentUserLeftChat: false,
            loadingPrivateEvents: false,
            futureConnectedPrivateEvents: [],
            loadingMessages: false,
            currentChat: groupchat,
            loadingChat: false,
            users: [],
            leftUsers: [],
          ),
        );
        emitState(
          chatState: state.chatState != null
              ? CurrentChatState.merge(
                  oldState: state.chatState!,
                  currentChat: replacedChat.currentChat)
              : CurrentChatState(
                  currentUserIndex: -1,
                  currentUserLeftChat: false,
                  loadingPrivateEvents: false,
                  futureConnectedPrivateEvents: [],
                  loadingMessages: false,
                  currentChat: groupchat,
                  loadingChat: false,
                  users: [],
                  leftUsers: [],
                ),
          loadingGroupchat: false,
        );
      },
    );
  }

  Future getCurrentPrivateEvent() async {
    emitState(loadingPrivateEvent: true);

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
    );

    privateEventOrFailure.fold(
      (error) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "Fehler Geradiges Event",
            message: mapFailureToMessage(error),
          ),
        );
        emitState(loadingPrivateEvent: false);
      },
      (privateEvent) {
        final replacedPrivateEvent = privateEventCubit.replaceOrAdd(
          privateEvent: privateEvent,
          mergeChatSetUsersFromOldEntity: false,
        );
        emitState(
          privateEvent: replacedPrivateEvent,
          loadingPrivateEvent: false,
        );
      },
    );
  }

  Future updateCurrentPrivateEvent({
    required UpdatePrivateEventDto updatePrivateEventDto,
  }) async {
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEvent(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
      updatePrivateEventDto: updatePrivateEventDto,
    );

    privateEventOrFailure.fold(
      (error) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "Update Event Fehler",
            message: mapFailureToMessage(error),
          ),
        );
        emitState(loadingPrivateEvent: false);
      },
      (privateEvent) {
        final replacedPrivateEvent = privateEventCubit.replaceOrAdd(
          privateEvent: privateEvent,
          mergeChatSetUsersFromOldEntity: false,
        );
        emitState(
          privateEvent: replacedPrivateEvent,
          loadingPrivateEvent: false,
          status: CurrentPrivateEventStateStatus.updated,
        );
      },
    );
  }

  Future deleteCurrentPrivateEventViaApi() async {
    final Either<Failure, bool> deletedOrFailure =
        await privateEventUseCases.deletePrivateEventViaApi(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
    );

    deletedOrFailure.fold(
      (error) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Delete Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (deleted) {
        if (deleted) {
          emitState(status: CurrentPrivateEventStateStatus.deleted);
          privateEventCubit.delete(privateEventId: state.privateEvent.id);
        }
      },
    );
  }

  Future addUserToPrivateEventViaApi({required String userId}) async {
    Either<Failure, PrivateEventUserEntity> privateEventUserOrFailure =
        await privateEventUseCases.addUserToPrivateEventViaApi(
      createPrivateEventUserDto: CreatePrivateEventUserDto(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventUserOrFailure.fold(
      (error) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Create Event User Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEventUser) {
        final List<PrivateEventUserEntity> privateEventUsers = List.from(
          state.privateEventUsers.map((e) => e.privateEventUser).toList(),
        )..add(privateEventUser);

        final List<PrivateEventLeftUserEntity> privateEventLeftUsers = state
            .privateEventLeftUsers
            .where((element) => element.user.id != userId)
            .map((e) => e.privateEventLeftUser)
            .toList();

        setPrivateEventUsers(
          eitherLeftUsers: Right(privateEventLeftUsers),
          eitherUsers: Right(privateEventUsers),
        );
      },
    );
  }

  Future updatePrivateEventUser({
    String? status,
    bool? organizer,
    required String userId,
  }) async {
    final Either<Failure, PrivateEventUserEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEventUser(
      updatePrivateEventUserDto: UpdatePrivateEventUserDto(
        status: status,
        organizer: organizer,
      ),
      getOnePrivateEventFilter: GetOnePrivateEventUserFilter(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventOrFailure.fold(
      (error) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEventUser) {
        List<PrivateEventUserEntity> privateEventUsers =
            state.privateEventUsers.map((e) => e.privateEventUser).toList();

        final index = privateEventUsers.indexWhere(
          (element) => element.userId == userId,
        );
        privateEventUsers[index] = privateEventUser;

        setPrivateEventUsers(
          eitherUsers: Right(privateEventUsers),
          eitherLeftUsers: Left(state.privateEventLeftUsers),
        );
      },
    );
  }

  Future deleteUserFromPrivateEventViaApi({required String userId}) async {
    Either<Failure, PrivateEventLeftUserEntity> privateEventLeftUserOrFailure =
        await privateEventUseCases.deleteUserFromPrivateEventViaApi(
      getOnePrivateEventUserFilter: GetOnePrivateEventUserFilter(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventLeftUserOrFailure.fold(
      (error) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Delete Event User Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEventLeftUser) {
        final List<PrivateEventLeftUserEntity> privateEventLeftUsers =
            List.from(
          state.privateEventLeftUsers
              .map((e) => e.privateEventLeftUser)
              .toList(),
        )..add(privateEventLeftUser);

        final List<PrivateEventUserEntity> privateEventUsers = state
            .privateEventUsers
            .where((element) => element.user.id != userId)
            .map((e) => e.privateEventUser)
            .toList();

        setPrivateEventUsers(
          eitherUsers: Right(privateEventUsers),
          eitherLeftUsers: Right(privateEventLeftUsers),
        );
      },
    );
  }

  Future openMaps() async {
    final Either<String, Unit> openedOrFailure =
        await locationUseCases.openMaps(
      query:
          "${state.privateEvent.eventLocation!.street} ${state.privateEvent.eventLocation!.housenumber}, ${state.privateEvent.eventLocation!.city}, ${state.privateEvent.eventLocation!.zip}, ${state.privateEvent.eventLocation!.country}",
    );

    openedOrFailure.fold(
      (errorMsg) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Google Maps Fehler",
          message: errorMsg,
        ),
      ),
      (_) => null,
    );
  }

  // shopping list

  CurrentShoppingListItemState replaceOrAddShoppingListItem({
    required bool addIfItsNotFound,
    required CurrentShoppingListItemState shoppingListItemState,
  }) {
    int foundIndex = state.shoppingListItemStates.indexWhere(
      (element) =>
          element.shoppingListItem.id ==
          shoppingListItemState.shoppingListItem.id,
    );

    if (foundIndex != -1) {
      List<CurrentShoppingListItemState> newShoppingListItemStates =
          state.shoppingListItemStates;
      newShoppingListItemStates[foundIndex] = shoppingListItemState;
      emitState(shoppingListItemStates: newShoppingListItemStates);
      return newShoppingListItemStates[foundIndex];
    } else if (addIfItsNotFound) {
      emitState(
        shoppingListItemStates: List.from([shoppingListItemState])
          ..addAll(
            state.shoppingListItemStates,
          ),
      );
    }
    return shoppingListItemState;
  }

  List<CurrentShoppingListItemState> replaceOrAddMultipleShoppingListItems({
    required bool addIfItsNotFound,
    required List<CurrentShoppingListItemState> shoppingListItemStates,
  }) {
    List<CurrentShoppingListItemState> mergedShoppingListItemStates = [];
    for (final shoppingListItemState in shoppingListItemStates) {
      final mergedShoppingListItemState = replaceOrAddShoppingListItem(
        addIfItsNotFound: addIfItsNotFound,
        shoppingListItemState: shoppingListItemState,
      );
      mergedShoppingListItemStates.add(mergedShoppingListItemState);
    }
    return mergedShoppingListItemStates;
  }

  void deleteShoppingListItem({required String shoppingListItemId}) {
    emitState(
      shoppingListItemStates: state.shoppingListItemStates
          .where(
            (element) => element.shoppingListItem.id != shoppingListItemId,
          )
          .toList(),
    );
  }

  Future getShoppingListItemsViaApi({
    bool reload = false,
  }) async {
    emitState(loadingShoppingList: true);

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter:
          GetShoppingListItemsFilter(privateEventId: state.privateEvent.id),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItemStates.length > 20
                  ? 20
                  : state.shoppingListItemStates.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.shoppingListItemStates.length,
            ),
    );

    shoppingListItemsOrFailure.fold(
      (error) {
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: "Lade Fehler",
            message: mapFailureToMessage(error),
          ),
        );
        emitState(loadingShoppingList: false);
      },
      (shoppingListItems) {
        if (reload) {
          emitState(
            loadingShoppingList: false,
            shoppingListItemStates: shoppingListItems
                .map(
                  (e) => CurrentShoppingListItemState(
                    loadingShoppingListItem: false,
                    loadingBoughtAmounts: false,
                    shoppingListItem: e,
                    boughtAmounts: [],
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultipleShoppingListItems(
            shoppingListItemStates: shoppingListItems
                .map(
                  (e) => CurrentShoppingListItemState(
                    loadingShoppingListItem: false,
                    loadingBoughtAmounts: false,
                    shoppingListItem: e,
                    boughtAmounts: [],
                  ),
                )
                .toList(),
            addIfItsNotFound: true,
          );
          emitState(loadingShoppingList: false);
        }
      },
    );
  }

  //

  void emitState({
    PrivateEventEntity? privateEvent,
    List<UserWithPrivateEventUserData>? privateEventUsers,
    List<LeftUserWithPrivateEventUserData>? privateEventLeftUsers,
    CurrentChatState? chatState,
    int? currentUserIndex,
    bool? loadingPrivateEvent,
    bool? loadingGroupchat,
    bool? loadingShoppingList,
    List<CurrentShoppingListItemState>? shoppingListItemStates,
    CurrentPrivateEventStateStatus? status,
  }) {
    emit(CurrentPrivateEventState(
      currentUserIndex: currentUserIndex ?? state.currentUserIndex,
      shoppingListItemStates:
          shoppingListItemStates ?? state.shoppingListItemStates,
      loadingShoppingList: loadingShoppingList ?? state.loadingShoppingList,
      privateEvent: privateEvent ?? state.privateEvent,
      privateEventLeftUsers:
          privateEventLeftUsers ?? state.privateEventLeftUsers,
      privateEventUsers: privateEventUsers ?? state.privateEventUsers,
      chatState: chatState ?? state.chatState,
      loadingPrivateEvent: loadingPrivateEvent ?? state.loadingPrivateEvent,
      loadingGroupchat: loadingGroupchat ?? state.loadingGroupchat,
      status: status ?? CurrentPrivateEventStateStatus.initial,
    ));
  }
}
