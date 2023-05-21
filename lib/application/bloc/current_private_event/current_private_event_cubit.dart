import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user_status_enum.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_left_user/create_private_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/find_one_private_event_to_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/private_event_user/find_one_private_event_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/find_one_private_event_filter.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final HomeEventCubit homeEventCubit;
  final ChatCubit chatCubit;
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  final PrivateEventUseCases privateEventUseCases;
  final GroupchatUseCases groupchatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.authCubit,
    required this.locationUseCases,
    required this.homeEventCubit,
    required this.chatCubit,
    required this.groupchatUseCases,
    required this.shoppingListItemUseCases,
    required this.privateEventUseCases,
  });

  Future reloadPrivateEventStandardDataViaApi() async {
    emitState(loadingGroupchat: true, loadingPrivateEvent: true);

    final Either<NotificationAlert, PrivateEventDataResponse>
        privateEventDataOrFailure =
        await privateEventUseCases.getPrivateEventDataViaApi(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
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
      findOnePrivateEventToFilter: FindOnePrivateEventToFilter(
        privateEventTo: state.privateEvent.id,
      ),
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

  Future getCurrentChatViaApi() async {
    if (state.privateEvent.groupchatTo == null) {
      return;
    }
    emitState(loadingGroupchat: true);

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.getGroupchatViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.privateEvent.groupchatTo!,
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
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingPrivateEvent: false);
      },
      (privateEvent) {
        emitState(privateEvent: privateEvent, loadingPrivateEvent: false);
      },
    );
  }

  Future updateCurrentPrivateEvent({
    required UpdatePrivateEventDto updatePrivateEventDto,
  }) async {
    final Either<NotificationAlert, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEvent(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
      updatePrivateEventDto: updatePrivateEventDto,
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingPrivateEvent: false);
      },
      (privateEvent) {
        emitState(
          privateEvent: privateEvent,
          loadingPrivateEvent: false,
          status: CurrentPrivateEventStateStatus.updated,
        );
      },
    );
  }

  Future deleteCurrentPrivateEventViaApi() async {
    final Either<NotificationAlert, bool> deletedOrFailure =
        await privateEventUseCases.deletePrivateEventViaApi(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
    );

    deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (deleted) {
        if (deleted) {
          emitState(status: CurrentPrivateEventStateStatus.deleted);
          homeEventCubit.delete(privateEventId: state.privateEvent.id);
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
    PrivateEventUserStatusEnum? status,
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
      findOnePrivateEventUserFilter: FindOnePrivateEventUserFilter(
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
      createPrivateEventLeftUserDto: CreatePrivateEventLeftUserDto(
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
    final Either<NotificationAlert, Unit> openedOrFailure =
        await locationUseCases.openMaps(
      query:
          "${state.privateEvent.eventLocation!.street} ${state.privateEvent.eventLocation!.housenumber}, ${state.privateEvent.eventLocation!.city}, ${state.privateEvent.eventLocation!.zip}, ${state.privateEvent.eventLocation!.country}",
    );

    openedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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
      findShoppingListItemsFilter: FindShoppingListItemsFilter(
        privateEventId: state.privateEvent.id,
      ),
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
    final CurrentPrivateEventState newState = CurrentPrivateEventState(
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
    );

    emit(newState);
    homeEventCubit.replaceOrAdd(
      privateEventState: newState,
      onlyReplace: true,
    );
  }
}
