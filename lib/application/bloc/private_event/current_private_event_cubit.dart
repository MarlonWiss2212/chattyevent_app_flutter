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
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/get_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:social_media_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
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
  final NotificationCubit notificationCubit;

  final PrivateEventUseCases privateEventUseCases;
  final ChatUseCases chatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.authCubit,
    required this.locationUseCases,
    required this.privateEventCubit,
    required this.chatCubit,
    required this.chatUseCases,
    required this.shoppingListItemUseCases,
    required this.privateEventUseCases,
  });

  Future reloadPrivateEventStandardDataViaApi() async {
    emitState(loadingGroupchat: true, loadingPrivateEvent: true);

    final Either<NotificationAlert, PrivateEventDataResponse>
        privateEventDataOrFailure =
        await privateEventUseCases.getPrivateEventDataViaApi(
      getOnePrivateEventFilter:
          GetOnePrivateEventFilter(id: state.privateEvent.id),
      groupchatId: state.privateEvent.groupchatTo,
    );

    privateEventDataOrFailure.fold(
      (alert) {
        emitState(loadingGroupchat: false, loadingPrivateEvent: false);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (data) {
        emitState(
          loadingGroupchat: false,
          loadingPrivateEvent: false,
          privateEvent: data.privateEvent,
          privateEventUsers: data.privateEventUsers,
          currentUserIndex: data.privateEventUsers.indexWhere(
            (element) => element.id == authCubit.state.currentUser.id,
          ),
          privateEventLeftUsers: data.privateEventLeftUsers,
          chatState: data.groupchat != null
              ? CurrentChatState(
                  currentUserIndex: -1,
                  currentUserLeftChat: false,
                  loadingPrivateEvents: false,
                  futureConnectedPrivateEvents: [],
                  loadingMessages: false,
                  currentChat: data.groupchat!,
                  messages: data.groupchat!.latestMessage != null
                      ? [data.groupchat!.latestMessage!]
                      : [],
                  loadingChat: false,
                  users: [],
                  leftUsers: [],
                )
              : null,
        );
      },
    );
  }

  Future getPrivateEventUsersAndLeftUsersViaApi() async {
    final Either<NotificationAlert, PrivateEventUsersAndLeftUsersResponse>
        usersOrFailure =
        await privateEventUseCases.getPrivateEventUsersAndLeftUsers(
      privateEventId: state.privateEvent.id,
    );

    usersOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (usersAndLeftUsers) {
        emitState(
          privateEventUsers: usersAndLeftUsers.privateEventUsers,
          privateEventLeftUsers: usersAndLeftUsers.privateEventLeftUsers,
          currentUserIndex: usersAndLeftUsers.privateEventUsers.indexWhere(
            (element) => element.id == authCubit.state.currentUser.id,
          ),
        );
      },
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

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(
        id: state.privateEvent.groupchatTo!,
      ),
    );

    await groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
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
            messages: groupchat.latestMessage != null
                ? [groupchat.latestMessage!]
                : [],
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
                  messages: groupchat.latestMessage != null
                      ? [groupchat.latestMessage!]
                      : [],
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

    final Either<NotificationAlert, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
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
    final Either<NotificationAlert, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEvent(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
      updatePrivateEventDto: updatePrivateEventDto,
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
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
    final Either<NotificationAlert, bool> deletedOrFailure =
        await privateEventUseCases.deletePrivateEventViaApi(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
    );

    deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (deleted) {
        if (deleted) {
          emitState(status: CurrentPrivateEventStateStatus.deleted);
          privateEventCubit.delete(privateEventId: state.privateEvent.id);
        }
      },
    );
  }

  Future addUserToPrivateEventViaApi({required String userId}) async {
    Either<NotificationAlert, PrivateEventUserEntity>
        privateEventUserOrFailure =
        await privateEventUseCases.addUserToPrivateEventViaApi(
      createPrivateEventUserDto: CreatePrivateEventUserDto(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventUser) {
        emitState(
          privateEventUsers: List.from(state.privateEventUsers)
            ..add(privateEventUser),
          privateEventLeftUsers: state.privateEventLeftUsers
              .where(
                (element) => element.id != privateEventUser.id,
              )
              .toList(),
        );
      },
    );
  }

  Future updatePrivateEventUser({
    String? status,
    bool? organizer,
    required String userId,
  }) async {
    final Either<NotificationAlert, PrivateEventUserEntity>
        privateEventOrFailure =
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventUser) {
        List<PrivateEventUserEntity> privateEventUsers =
            state.privateEventUsers;

        final index = privateEventUsers.indexWhere(
          (element) => element.id == userId,
        );
        if (index == -1) {
          privateEventUsers.add(privateEventUser);
        } else {
          privateEventUsers[index] = privateEventUser;
        }

        emitState(
          privateEventUsers: privateEventUsers,
          privateEventLeftUsers: state.privateEventLeftUsers,
        );
      },
    );
  }

  Future deleteUserFromPrivateEventViaApi({required String userId}) async {
    Either<NotificationAlert, PrivateEventLeftUserEntity>
        privateEventLeftUserOrFailure =
        await privateEventUseCases.deleteUserFromPrivateEventViaApi(
      getOnePrivateEventUserFilter: GetOnePrivateEventUserFilter(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventLeftUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventLeftUser) {
        emitState(
          privateEventUsers: state.privateEventUsers
              .where(
                (element) => element.id != userId,
              )
              .toList(),
          privateEventLeftUsers: List.from(state.privateEventLeftUsers)
            ..add(privateEventLeftUser),
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

  Future getShoppingListItemsViaApi({bool reload = false}) async {
    emitState(loadingShoppingList: true);

    final Either<NotificationAlert, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter:
          GetShoppingListItemsFilter(privateEventId: state.privateEvent.id),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItemStates.length < 20
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
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
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

  void emitState({
    PrivateEventEntity? privateEvent,
    List<PrivateEventUserEntity>? privateEventUsers,
    List<PrivateEventLeftUserEntity>? privateEventLeftUsers,
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
